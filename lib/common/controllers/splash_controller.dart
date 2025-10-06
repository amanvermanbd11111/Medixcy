import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // CubeSettings.instance.isDebugEnabled = false;
    // Get.isLogEnable = false;
    getToken();
  }

  getToken() async {

    getCC();

    Timer(Duration(seconds: 2), () {

      print("StorageService.readData(key: LocalStorageKeys.isLoggedInAsDoctor)");
      print(StorageService.readData(key: LocalStorageKeys.isLoggedInAsDoctor));
      print(StorageService.readData(key: LocalStorageKeys.isLoggedIn));
      print(StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy));
      print(StorageService.readData(key: LocalStorageKeys.isTokenExist));

      if (StorageService.readData(key: LocalStorageKeys.isLoggedInAsDoctor) ??
          false) {

        fetchSubList("${StorageService.readData(key: LocalStorageKeys.userId)}");

        // Get.offAllNamed(Routes.doctorTabScreen);
      }
      else if (StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy) ??
          false){
        Get.offAllNamed(Routes.doctorTabScreen);
      }
      else if (StorageService.readData(key: LocalStorageKeys.isLoggedInAsLaboratory) ??
          false){
        Get.offAllNamed(Routes.doctorTabScreen);
      }
      else if (StorageService.readData(key: LocalStorageKeys.isLoggedIn) ??
          false) {
        Get.offAllNamed(Routes.userTabScreen);
      }
      else {
        //Get.offAllNamed(Routes.userTabScreen);
        Get.offAllNamed(Routes.introScreen);

      }
    });


  }
  fetchSubList(String docId) async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctor_subscription_list?doctor_id=${docId}"))
        .timeout(const Duration(seconds: Apis.timeOut));

    print(response.statusCode);
    print(response.request);

    try {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        print(jsonResponse);
        if(jsonResponse["data"]["doctors_subscription"].length != 0){
          Get.offAllNamed(Routes.doctorTabScreen);
          changeNotifier.updateString("Done");

          print("go to home");
        }else{
          Get.toNamed(Routes.chooseYourPlanScreen, arguments: {
            'doctorUrl': "${StorageService.readData(key: LocalStorageKeys.userId)?? ""}"
          });
          print("go to subscription");
        }



      }
    } catch (e) {
      print(e);
    }
    Client().close();
  }

  getCC() {
    SharedPrefs.getUser().then((value) {
      if (value == null) return;
      ConnectyCubeSessionService.loginToCC(
        value,
        onTap: () => changeNotifier.updateString("Done"),
      );
    });
  }
}
