import 'package:videocalling_medical/common/utils/app_imports.dart';

class OtpLoginController extends GetxController {
  /// Whether we’re on the OTP step or the phone step
  var showOtpView = false.obs;

  /// Phone number typed by user
  var phoneNumber = ''.obs;

  /// OTP entered by user
  var otpCode = ''.obs;

  TextEditingController phoneTextField = TextEditingController();


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
  void verifyOtp() async{
    if (otpCode.value.length == 6) {
      //Get.snackbar('Success', 'OTP Verified Successfully');
      // TODO: Navigate to HomeScreen
      // Get.offAll(() => const HomeScreen());

      customDialog1(s1: 'loading'.tr, s2: 'please_wait_while_processing'.tr);


      try {
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

          if (jsonResponse['success'] == 1) {
            print("User exists!");
            Get.back();

            Get.offAllNamed(Routes.userTabScreen);


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
      Get.snackbar('Error', 'Please enter a valid OTP');
    }
  }

  /// Handle resend
  void resendOtp() {
    // TODO: call your backend to resend OTP
    Get.snackbar('Info', 'OTP Resent Successfully');
  }

  /// Go back to phone view
  void backToPhone() => showOtpView.value = false;


}
