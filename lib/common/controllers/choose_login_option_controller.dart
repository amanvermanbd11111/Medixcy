import 'package:videocalling_medical/common/utils/app_imports.dart';

class LoginOptionsController extends GetxController {
  final loginOptions = <LoginOptionData>[
    LoginOptionData(
      title: 'Login as patient',
      imagePath: AppImages.loginOption1,
      onTap: () => Get.to(OtpLoginScreen()),
    ),
    LoginOptionData(
      title: 'Login as doctor',
      imagePath: AppImages.loginOption2,
      onTap: () => Get.to(OtpLoginScreen()),
    ),
    LoginOptionData(
      title: 'Login as student',
      imagePath: AppImages.loginOption3,
      onTap: () => Get.to(OtpLoginScreen()),
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
