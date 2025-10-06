import 'package:videocalling_medical/common/utils/app_imports.dart';

class LoginOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginOptionsController>(
          () => LoginOptionsController(),
    );
  }
}
