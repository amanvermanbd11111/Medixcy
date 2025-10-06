import 'package:videocalling_medical/common/utils/app_imports.dart';

class OtpLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpLoginController>(
          () => OtpLoginController(),
    );
  }
}
