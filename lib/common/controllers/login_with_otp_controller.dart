import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';


class OtpLoginController extends GetxController {
  bool isBack = Get.arguments['isBack'];

  /// Whether we’re on the OTP step or the phone step
  var showOtpView = false.obs;

  /// Phone number typed by user
  var phoneNumber = ''.obs;

  /// OTP entered by user
  var otpCode = ''.obs;

  TextEditingController phoneTextField = TextEditingController();

  RxString token = "".obs;
  RxString pass = "12345678".obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
  }



  /// Handle send OTP button
  void sendOtp() async{
    if (phoneNumber.value.isNotEmpty) {
      // TODO: call your backend to send OTP
      customDialog1(s1: 'loading'.tr, s2: 'please_wait_while_processing'.tr);
      print("check1");

      try {
        final url = Uri.parse("${Apis.ServerAddress}/api/send_otp");

        print("Request URL: $url");


        final response = await post(url,body: {
          "phone":phoneTextField.text,
          "request_from":"mobile"
        }).timeout(Duration(seconds: Apis.timeOut));

        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200) {
          print("check3");

          final jsonResponse = jsonDecode(response.body);

          if (jsonResponse['success'] == 1) {
            print("User exists!");

            //phone.value= jsonResponse['register']['phone'].toString();
            //messageDialog('OTP sent'.tr, 'OTP sent on your ${phoneTextField.text} ', 0);
            Get.back();
            if(jsonResponse['msg'] == 'OTP SENT'){
              print("change to verify screen");
              showOtpView.value = true;
            }

            //messageDialog('Your OTP '.tr, '123456', 0);

          }else{
            Get.back();
           // messageDialog0('${phoneTextField.text} Not Found', 'Register now', 0);
          }
        } else {
          Get.back();
         // messageDialog('error'.tr, 'Failed to fetch data. Status code: ${response.statusCode}', 0);
        }
      } catch (e) {
        print("check error : "+e.toString());
        Get.back();
        //messageDialog('error'.tr, e.toString(), 0);
      }




    } else {
      Get.snackbar('Error', 'Please enter your phone number');
    }
  }

  /// Handle OTP verification button
  void verifyOtp(int type) async{


    if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      storeToken();
    } else {

      if (otpCode.value.length == 6) {
        //Get.snackbar('Success', 'OTP Verified Successfully');
        // TODO: Navigate to HomeScreen
        // Get.offAll(() => const HomeScreen());

        customDialog1(s1: 'loading'.tr, s2: 'please_wait_while_processing'.tr);


        try
        {
          final url = Uri.parse("${Apis.ServerAddress}/api/verify_otp");

          print("Request URL: $url");


          final response = await post(url,body: {
            "phone":phoneTextField.text,
            "otp":otpCode.value
          }).timeout(Duration(seconds: Apis.timeOut));

          print("Response Status Code: ${response.statusCode}");
          print("Response Body: ${response.body}");

          if (response.statusCode == 200) {
            print("check3");

            final jsonResponse = jsonDecode(response.body);





            if (jsonResponse['success'] == 1 && jsonResponse['new_user']==0) {
              // print("User exists!");
              // Get.back();
              //
              // //Get.offAllNamed(Routes.userTabScreen);
              //
              // await Get.toNamed(Routes.patientRegisterScreen);
              // Get.delete<RegisterPatientController>();

              Get.back();
              customDialog1(
                s1: 'creating_account_f'.tr,
                s2: 'creating_account1_f'.tr,
                s1style: Theme.of(Get.context!).textTheme.bodyLarge,
                s2style: Theme.of(Get.context!).textTheme.bodyMedium,
              );

              UserLoginResponse _response =
              UserLoginResponse.fromJson(jsonDecode(response.body));
              FirebaseDatabase.instance
                  .ref()
                  .child("117${_response.register!.userId}")
                  .update({
                "name": _response.register!.name,
                "image": _response.register!.profilePic,
              }).then((value) async {
                FirebaseDatabase.instance
                    .ref()
                    .child("117${_response.register!.userId}")
                    .child("TokenList")
                    .set({
                  "device": token.value,
                }).then((value) async {
                  StorageService.writeBoolData(
                    key: LocalStorageKeys.isLoggedIn,
                    value: true,
                  );
                  StorageService.writeStringData(
                      key: LocalStorageKeys.phone,
                      value: _response.register!.phone == null
                          ? ""
                          : _response.register!.phone.toString());
                  StorageService.writeStringData(
                      key: LocalStorageKeys.password, value: pass.value);
                  StorageService.writeStringData(
                      key: LocalStorageKeys.name, value: _response.register!.name ?? "");
                  StorageService.writeStringData(
                      key: LocalStorageKeys.email, value: _response.register!.email!);
                  StorageService.writeStringData(
                      key: LocalStorageKeys.userIdWithAscii,
                      value: ('117${_response.register!.userId}'));
                  StorageService.writeStringData(
                      key: LocalStorageKeys.callerImage,
                      value: _response.register!.profilePic!);
                  StorageService.writeStringData(
                      key: LocalStorageKeys.userId,
                      value: _response.register!.userId.toString());
                  StorageService.writeStringData(
                      key: LocalStorageKeys.profileImage,
                      value: _response.register!.profilePic!);

                  // print("_response.register?.connectycubeUserId.toString()");
                  // print(_response.register?.connectycubeUserId.toString());

                  CubeUser user = CubeUser(
                    id: _response.register?.connectycubeUserId ?? 00,
                    login: _response.register?.loginId ?? "00",
                    fullName: _response.register?.name.toString().replaceAll(" ", ""),
                    password: _response.register?.connectycubePassword.toString(),
                  );


                  ConnectyCubeSessionService.loginToCC(
                    user,
                    onTap: () {
                      if (isBack) {
                        Get.back();
                        Get.back(result: true);
                        changeNotifier.updateString("Done");
                      } else {
                        Get.offAllNamed(Routes.userTabScreen);
                        changeNotifier.updateString("Done");
                      }
                    },
                  );

                }).catchError((error) {
                  print("error1");
                  print(error);
                  Get.back();
                  messageDialog('error_f'.tr, 'firebase_not_add'.tr);
                });
              }).catchError((error) {
                print("error2");
                print(error);
                Get.back();
                messageDialog('error_f'.tr, 'firebase_not_add'.tr);
              });






            }
            else
            {
              Get.back();
              if(jsonResponse['new_user']==1)
                {
                  await Get.toNamed(Routes.patientRegisterScreen,arguments: {
                    "id": "1",
                    "isBack": false,
                    "phone":phoneTextField.text
                  });
                  Get.delete<RegisterPatientController>();
                }
              if(jsonResponse['success'] == 0 && jsonResponse['msg']=="OTP NOT MATCHED"){
                messageDialog('error'.tr, '${jsonResponse['msg']}');


              }

            }
          } else {
            Get.back();
            // messageDialog('error'.tr, 'Failed to fetch data. Status code: ${response.statusCode}', 0);
          }
        } catch (e) {
          print("check error : "+e.toString());
          Get.back();
          //messageDialog('error'.tr, e.toString(), 0);
        }







      } else {
        Get.snackbar('Error', 'Please enter a valid OTP');
      }

    }




  }

  /// Handle resend
  void resendOtp() {
    // TODO: call your backend to resend OTP
    Get.snackbar('Info', 'OTP Resent Successfully');
    //sendOtp();
  }

  /// Go back to phone view
  void backToPhone() => showOtpView.value = false;



  getToken() async {
    if (StorageService.readData(key: LocalStorageKeys.isTokenExist) == null) {
      firebaseMessaging.getToken().then((value) {
        if (value == null) return;
        token.value = value;
      }).catchError((e) {
        messageDialog('error'.tr, 'unable_to_save_token'.tr);
      });
    } else {
      token.value = StorageService.readData(key: LocalStorageKeys.token);
    }
  }

  storeToken() async {
    print("token.value");
    print(token.value);
    customDialog1(
      s1: 'login_dialog_title'.tr,
      s2: 'login_dialog_description'.tr,
      s1style: Theme.of(Get.context!).textTheme.bodyLarge,
      s2style: Theme.of(Get.context!).textTheme.bodyMedium,
    );
    if (token.value.isEmpty) {
      await getToken();
    }
    final response = await post(Uri.parse("${Apis.ServerAddress}/api/savetoken"), body: {
      "token": token.value,
      "type": "1",
    }).catchError((e) {
      messageDialog('error'.tr, 'unable_to_save_token'.tr);
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        StorageService.writeBoolData(
          key: LocalStorageKeys.isTokenExist,
          value: true,
        );
        StorageService.writeStringData(
          key: LocalStorageKeys.token,
          value: token.value,
        );
        Get.back();
        verifyOtp(1);
      } else {
        Get.back();
        messageDialog('error'.tr, "${jsonResponse['register']}");
      }
    } else {
      Get.back();
      messageDialog('error'.tr, response.body.toString());
    }
  }


  messageDialog(String s1, String s2) {
    customDialog(
      s1: s1,
      s2: s2,
      s1style: Theme.of(Get.context!).textTheme.bodyLarge,
      s2style: Theme.of(Get.context!).textTheme.bodyLarge,
      s3style: Theme.of(Get.context!).textTheme.bodyLarge,
    );
  }



}
