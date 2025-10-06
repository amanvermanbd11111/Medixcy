import 'package:videocalling_medical/common/utils/app_imports.dart';


class IntroductionController extends GetxController {
  // Introduction pages data
  final List<IntroPageData> introPages = [
    IntroPageData(
      title: "Welcome to",
      textImg: AppImages.medixcy_text,
      description: "Simplify your health journey.\nAccess expert advice, virtual\nconsultations, and doorstep\nmedicine delivery \nall in one app.",
      imagePath: AppImages.intro1,
      highlightWords: ["MEDXICY", "all in one app."],
    ),
    IntroPageData(
      title: "Simplify Your Consultations,\nGrow Your Impact!",
      description: "Streamline your consultations and\nfocus on delivering exceptional\ncare to more patients",
      imagePath: AppImages.intro2,
    ),
    IntroPageData(
      title: "Empower Your Practice,\nReach More Patients",
      description: "With our app, enhance your\npractice by connecting with a\nbroader patient base effortlessly.",
      imagePath: AppImages.intro3,
    ),
    IntroPageData(
      title: "Your Health,\n        Our Priority",
      description: "From consultations to medicines\nand tests, we ensure healthcare\n is simple, accessible,\ncomprehensive care designed\nfor you.",
      imagePath: AppImages.intro4,
      highlightWords: ["Our Priority", "healthcare\n is simple, accessible,"],

    ),
  ];

  // Navigate to home or main screen
  void onDonePressed() {
    // Navigate to your main screen
    // Get.offAllNamed('/home');
    //Get.snackbar('Done', 'Introduction completed!');
    Get.toNamed(Routes.chooseLoginOption);


  }

  // Skip introduction
  void onSkipPressed() {
    // Navigate to your main screen
    // Get.offAllNamed('/home');
    Get.snackbar('Skipped', 'Introduction skipped!');
  }
}

class IntroPageData {
  final String title;
  final String? textImg;
  final String description;
  final String imagePath;
  final List<String> highlightWords; // <-- NEW


  IntroPageData({
    required this.title,
    this.textImg,
    required this.description,
    required this.imagePath,
    this.highlightWords = const [],

  });
}