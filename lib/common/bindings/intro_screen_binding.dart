import 'package:videocalling_medical/common/utils/app_imports.dart';

class IntroScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionController>(
          () => IntroductionController(),
    );
  }
}
