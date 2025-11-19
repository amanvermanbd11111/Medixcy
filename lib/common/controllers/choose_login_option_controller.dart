import 'package:videocalling_medical/common/utils/app_imports.dart';

class LoginOptionsController extends GetxController {
  final loginOptions = <LoginOptionData>[
    LoginOptionData(
      title: 'Login as patient',
      imagePath: AppImages.loginOption1,
      onTap: () async{
  await Get.toNamed(Routes.loginWithOtpScreen,
  arguments: {
  "isBack": false,
  });
  }
  ),
    LoginOptionData(
      title: 'Login as doctor',
      imagePath: AppImages.loginOption2,
      onTap: () {}),

    LoginOptionData(
      title: 'Login as student',
      imagePath: AppImages.loginOption3,
      onTap: () => null,
    ),
  ].obs;
}

/// Plain data model
class LoginOptionData {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  LoginOptionData({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
