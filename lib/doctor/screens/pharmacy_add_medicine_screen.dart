import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/doctor/screens/pharmacy_medicine_edit_screen.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';
import 'package:videocalling_medical/main.dart';

class PharmacyAddMedicineScreen extends GetView<DMoreInfoController> {

  final DMoreInfoController controller = Get.put(DMoreInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: CustomAppBar(
          title: controller.loginKey.value == pharmacyKey
              ? 'medicine_str'.tr
              : 'report_str'.tr,
          textStyle: Theme.of(context).textTheme.headlineSmall!.apply(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeightDelta: 5,
          ),
        ),
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 6),

              controller.isLoaded.value

                  ? Expanded(
                child: ListView.builder(
                  controller:
                  controller.allMedicineScrollController,
                  itemCount:
                  controller.medicineAllData!.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          if(controller.loginKey.value == pharmacyKey)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.greyShade3,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  child: controller.medicineAllData!
                                      .data![index].image ==
                                      "null"
                                      ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          12),
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    child: Opacity(
                                      opacity: 0.60,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(12),
                                        child: Image.asset(
                                          AppImages.medicine1,
                                          fit: BoxFit.contain,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        12),
                                    child: Image.network(
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      "${Apis.medicineImage}${controller.medicineAllData!.data![index].image}",
                                      errorBuilder: (context,
                                          error, stackTrace) {
                                        return Image.asset(
                                          AppImages.medicine1,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          if(controller.loginKey.value == pharmacyKey)
                            const SizedBox(width: 10),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    children: [

                                      Expanded(
                                        child: Text(
                                          controller
                                              .medicineAllData!
                                              .data![index]
                                              .name ??
                                              "",
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily:
                                            AppFontStyleTextStrings
                                                .medium,
                                            color: AppColors
                                                .reportTextColor,
                                          ),
                                        ),
                                      ),

                                      if(controller.loginKey.value == labKey)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 12, left: 8),
                                          child: Text(
                                            " ${(double.parse(controller.medicineAllData!.data![index].price!.toString()).toStringAsFixed(1)).toString()}$CURRENCY",
                                            style: TextStyle(
                                              fontFamily:
                                              AppFontStyleTextStrings
                                                  .medium,
                                              fontSize: 15,
                                              color: AppColors.color1,
                                            ),
                                          ),
                                        ),

                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  if(controller.loginKey.value == pharmacyKey)
                                    Row(
                                      children: [
                                        Text(
                                          "medicine_price".tr,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily:
                                            AppFontStyleTextStrings
                                                .medium,
                                            fontSize: 15,
                                            color: AppColors.color1,
                                          ),
                                        ),
                                        Text(
                                          " ${(double.parse(controller.medicineAllData!.data![index].price!.toString()).toStringAsFixed(1)).toString()}$CURRENCY",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily:
                                            AppFontStyleTextStrings
                                                .medium,
                                            fontSize: 15,
                                            color: AppColors.color1,
                                          ),
                                        ),
                                      ],
                                    ),


                                  if(controller.loginKey.value == labKey)
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${controller.medicineAllData!.data![index].description!.toString()}",
                                            // maxLines: 2,
                                            style: TextStyle(
                                              fontFamily:
                                              AppFontStyleTextStrings
                                                  .medium,
                                              fontSize: 10,
                                              color: AppColors.LIGHT_GREY_TEXT,
                                            ),
                                          ),
                                        ),

                                        if(controller.loginKey.value == labKey)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 12, left: 8),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                InkWell(
                                                  onTap: () async {
                                                    controller.nameController
                                                        .clear();
                                                    controller.feeController
                                                        .clear();
                                                    controller.aboutUsController
                                                        .clear();
                                                    controller.imagePath.value = '';
                                                    controller.sImage = null;

                                                    if(controller.loginKey.value == pharmacyKey) {
                                                      controller.getMedicineData(
                                                          controller.medicineAllData!
                                                              .data![index].id
                                                              .toString());
                                                    }else{
                                                      controller.getReportData(
                                                          controller.medicineAllData!
                                                              .data![index].id
                                                              .toString());
                                                    }

                                                    controller.isEdit.value = true;
                                                    Get.to(
                                                        PharmacyMedicineEditScreen())!.then((value) {
                                                      controller.isEdit.value = false;

                                                    },);
                                                  },
                                                  child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                          color: AppColors.color1),
                                                      child: SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: Image.asset(
                                                          AppImages
                                                              .editicon_medicine,
                                                          color: AppColors.WHITE,
                                                        ),
                                                      )),
                                                ),

                                                // SizedBox(height: 10,),
                                                //
                                                // InkWell(
                                                //   onTap: () async {
                                                //
                                                //
                                                //     controller.isEdit.value = true;
                                                //     Get.to(
                                                //         PharmacyMedicineEditScreen())!.then((value) {
                                                //       controller.isEdit.value = false;
                                                //
                                                //     },);
                                                //   },
                                                //   child: Container(
                                                //     height: 25,
                                                //     width: 25,
                                                //     alignment: Alignment.center,
                                                //     decoration: BoxDecoration(
                                                //         borderRadius: const BorderRadius.all(
                                                //             Radius.circular(4),
                                                //         ),
                                                //         border: Border.all(
                                                //             color: Colors.red),
                                                //         color: AppColors.greyShade1),
                                                //     child: SizedBox(
                                                //       height: 25,
                                                //       width: 25,
                                                //       child: Image.asset(
                                                //         AppImages.deleteicon,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if(controller.loginKey.value == pharmacyKey)
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 12, left: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  InkWell(
                                    onTap: () async {
                                      controller.nameController
                                          .clear();
                                      controller.feeController
                                          .clear();
                                      controller.aboutUsController
                                          .clear();
                                      controller.imagePath.value = '';
                                      controller.sImage = null;

                                      if(controller.loginKey.value == pharmacyKey) {
                                        controller.getMedicineData(
                                            controller.medicineAllData!
                                                .data![index].id
                                                .toString());
                                      }else{
                                        controller.getReportData(
                                            controller.medicineAllData!
                                                .data![index].id
                                                .toString());
                                      }

                                      controller.isEdit.value = true;
                                      Get.to(
                                          PharmacyMedicineEditScreen())!.then((value) {
                                        controller.isEdit.value = false;

                                      },);
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                            color: AppColors.color1),
                                        child: SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Image.asset(
                                            AppImages
                                                .editicon_medicine,
                                            color: AppColors.WHITE,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              )

                  : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).hintColor),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              InkWell(
                onTap: () async {
                  controller.nameController.clear();
                  controller.feeController.clear();
                  controller.aboutUsController.clear();
                  controller.imagePath.value = '';
                  controller.sImage = null;
                  Get.to(PharmacyMedicineEditScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.color1,
                          AppColors.color2,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  height: 50,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.loginKey.value == pharmacyKey
                            ? 'add_medicine'.tr
                            : 'add_report_str'.tr,
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            fontWeightDelta: 1,
                            color: AppColors.WHITE,
                            fontSizeDelta: 5),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.add,
                        color: AppColors.WHITE,
                        size: 27,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),
            ],
          );
        }),
      ),
    );
  }
}
