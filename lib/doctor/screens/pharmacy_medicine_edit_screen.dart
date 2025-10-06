import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

import '../../main.dart';
import '../controllers/pharmacy_edit_medicine_controller.dart';

class PharmacyMedicineEditScreen extends GetView<DMoreInfoController> {

  final DMoreInfoController controller = Get.put(DMoreInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          isBackArrow: true,
          onPressed: () => Get.back(),
          title:
          controller.loginKey.value == labKey
              ?

          controller.isEdit.value
              ?'edit_report_str'.tr
              :
          'add_report_str'.tr
              : controller.isEdit.value
              ?'edit_medicine_str'.tr
              :
          "add_medicine_str".tr,
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeightDelta: 5,
          ),
        ),
        leading: Container(),
      ),
      body:
      Container(
        child:
        controller.loginKey.value == labKey

            ?controller.step2(context: context)
            :
        controller.step1(context: context),
      ),
    );
  }
}
