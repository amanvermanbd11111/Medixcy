import 'package:videocalling_medical/common/utils/app_imports.dart';

class LoginOptionsController extends GetxController {
  final loginOptions = <LoginOptionData>[
    LoginOptionData(
      title: 'Login as patient',
      imagePath: AppImages.loginOption1,
      onTap: (context) async{
  await Get.toNamed(Routes.loginWithOtpScreen,
  arguments: {
  "isBack": false,
  });
  }
  ),
    LoginOptionData(
      title: 'Login as doctor',
      imagePath: AppImages.loginOption2,
      onTap: (context) {

        showComingSoonDialog(Get.context!);
      }),

    LoginOptionData(
      title: 'Login as student',
      imagePath: AppImages.loginOption3,
      onTap: (context) {

        showComingSoonDialog(Get.context!);
      },
    ),


  ].obs;



}



void showComingSoonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Coming Soon",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "We are working on this feature. It will be available soon!",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

/// Plain data model
class LoginOptionData {
  final String title;
  final String imagePath;
  final Function(BuildContext) onTap;

  LoginOptionData({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
