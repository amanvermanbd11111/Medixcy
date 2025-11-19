import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';

class MedicineOrderScreen extends GetView<MedicineOrderController> {
  final MedicineOrderController medicineOrderController =
  Get.put(MedicineOrderController());

  ///type- 1 medicine order detail type- 2 prescription detail

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: medicineOrderController.isMedicine.toString() == "1"
              ? 'order_medicine'.tr
              : 'order_report'.tr,
          isBackArrow: true,
          onPressed: () => Get.back(),
          textStyle: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 22,
            fontFamily: AppFontStyleTextStrings.medium,
          ),
        ),
        leading: Container(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (medicineOrderController.phoneController.text.isEmpty) {
                  medicineOrderController.isPhoneError.value = true;
                  medicineOrderController.phoneErrorText.value =
                      'mobile_error_1'.tr;
                  if (medicineOrderController.phoneController.text.length <
                      PHONE_LENGTH) {
                    medicineOrderController.isPhoneError.value = true;
                    medicineOrderController.phoneErrorText.value =
                        'mobile_error_2'
                            .trParams({'length': PHONE_LENGTH.toString()});
                  }
                } else if (medicineOrderController.phoneController.text.length <
                    PHONE_LENGTH) {
                  medicineOrderController.isPhoneError.value = true;
                  medicineOrderController.phoneErrorText.value =
                      'mobile_error_2'
                          .trParams({'length': PHONE_LENGTH.toString()});
                }
                else if (medicineOrderController.a == null && medicineOrderController.isMedicine.toString() == "1") {
                  Fluttertoast.showToast(
                      msg: 'please_select_address'.tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.WHITE,
                      textColor: AppColors.BLACK,
                      fontSize: 16.0);
                }

                else if (medicineOrderController.isMedicine.toString() == "2" && medicineOrderController.isChargeName.toString() == "Home Visit".tr && medicineOrderController.a == null) {
                  Fluttertoast.showToast(
                      msg: 'please_select_address'.tr,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppColors.WHITE,
                      textColor: AppColors.BLACK,
                      fontSize: 16.0);
                }
                else if (medicineOrderController
                    .nameController.text.isEmpty) {
                  medicineOrderController.isNameError.value = true;
                }
                else {
                  if (medicineOrderController.type == 1) {
                    print("object789456123");
                    medicineOrderController.processPayment(context: context);
                  } else {
                    medicineOrderController.orderPrescription();
                  }
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.color1,
                      AppColors.color2,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                width: double.infinity,
                child: Row(
                  children: [

                    if (medicineOrderController.type == 1)...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextWidgets.mediumText(
                                text:
                                "${(medicineOrderController.price.value % 2 == 0 ? medicineOrderController.price.value.toStringAsFixed(1) : medicineOrderController.price.value.toStringAsFixed(1))}$CURRENCY",
                                color: AppColors.WHITE,
                                size: 15,
                              ),
                              AppTextWidgets.regularText(
                                text: 'total_price1'.tr,
                                color: AppColors.WHITE,
                                size: 9,
                              ),
                            ],
                          );
                        }),
                      ),
                      5.ws,
                      Container(
                        height: 70,
                        child: const VerticalDivider(
                          color: AppColors.WHITE,
                          indent: 5,
                          thickness: 0.5,
                          endIndent: 5,
                        ),
                      ),
                      3.ws,
                    ],

                    if (medicineOrderController.type == 2) 12.ws,
                    Expanded(
                      child: Text(
                        medicineOrderController.type == 1
                            ? 'proceed_payment'.tr
                            : 'order_now'.tr,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: AppFontStyleTextStrings.regular,
                          color: AppColors.WHITE,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.WHITE,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: medicineOrderController.type == 2
                ? Get.height - 139
                : Platform.isIOS
                ? Get.height - 220
                : Get.height - 190,
            child: Column(
              children: [
                if (medicineOrderController.type == 2) ...[
                  Text(
                    'order_detail_message'.tr,
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: AppFontStyleTextStrings.medium,
                      fontSize: 14,
                      color: AppColors.GREY,
                    ),
                  ),
                  Container(
                    height: Get.height * 0.35,
                    // width: Get.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        // fit: BoxFit.cover,
                        File(medicineOrderController.imgPath.value),
                      ),
                    ),
                  ),
                  15.hs,
                ],

                // Obx(
                //   () => EditTextField(
                //     keyboardType: TextInputType.emailAddress,
                //     editingController: medicineOrderController.nameController,
                //     labelText: 'enter_name'.tr,
                //     errorText: medicineOrderController.isNameError.value
                //         ? 'enter_name_error'.tr
                //         : null,
                //     onChanged: (val) {
                //       if (val.isNotEmpty) {
                //         medicineOrderController.isNameError.value = false;
                //       }
                //     },
                //   ),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),

                Obx(
                      () => EditTextField(
                    keyboardType: TextInputType.phone,
                    editingController: medicineOrderController.phoneController,
                    labelText: 'enter_number'.tr,
                    errorText: medicineOrderController.isPhoneError.value
                        ? medicineOrderController.phoneErrorText.value
                        : null,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        medicineOrderController.isPhoneError.value = false;
                      }
                    },
                  ),
                ),

                // const SizedBox(
                //   height: 8,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: EditTextFieldDateTime(
                //         onTap: () async {
                //           DateTime? date = await showDatePicker(
                //               context: context,
                //               firstDate: DateTime.now(),
                //               lastDate: DateTime(2100));
                //
                //           if (date != null) {
                //             medicineOrderController.dateController.text =
                //                 medicineOrderController.convertDate(dateTime: date);
                //             medicineOrderController.update();
                //           }
                //         },
                //         editingController: medicineOrderController.dateController,
                //         labelText: 'select_date'.tr,
                //         errorText: null,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     Expanded(
                //       child: EditTextFieldDateTime(
                //         onTap: () async {
                //           TimeOfDay? time = await showTimePicker(
                //             context: context,
                //             initialTime: TimeOfDay.now(),
                //           );
                //
                //           if (time != null) {
                //             medicineOrderController.timeController.text =
                //                 medicineOrderController.convertTime(time: time);
                //             medicineOrderController.update();
                //           }
                //         },
                //         editingController: medicineOrderController.timeController,
                //         labelText: 'select_time'.tr,
                //         errorText: null,
                //       ),
                //     ),
                //   ],
                // ),

                if(medicineOrderController.isMedicine.toString() == "1" || medicineOrderController.isChargeName.toString() == "Home Visit".tr)
                  ...[
                    12.hs,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'address'.tr,
                          style: TextStyle(
                            fontFamily: AppFontStyleTextStrings.medium,
                            fontSize: 16,
                            color: AppColors.reportTextColor,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Get.toNamed(Routes.selectAddressScreen)
                                ?.then((value) {
                              Get.delete<SelectAddressController>();
                              if (value != null) {
                                medicineOrderController.isDataLoaded.value =
                                false;
                                medicineOrderController.a = value;
                                medicineOrderController.isDataLoaded.value = true;
                              } else {
                                medicineOrderController.getAddress();
                              }
                            });
                          },
                          child: Text(
                            'select_address'.tr,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.regular,
                              fontSize: 14,
                              color: AppColors.reportTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    8.hs,
                    Obx(
                          () => medicineOrderController.isDataLoaded.value
                          ? Container(
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyShade3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicineOrderController.a == null
                                  ? "no_delivery_address".tr
                                  : "${medicineOrderController.a!.tag}",
                              style: const TextStyle(
                                fontFamily: AppFontStyleTextStrings.semiBold,
                                color: AppColors.BLACK45,
                                fontSize: 15,
                              ),
                            ),
                            5.hs,
                            if (medicineOrderController.a != null)
                              Text(
                                "${medicineOrderController.a!.address}",
                                style: const TextStyle(
                                  fontFamily: AppFontStyleTextStrings.medium,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                      )
                          : Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                        height: Get.height * 0.2,
                      ),
                    ),
                  ],


                Obx(
                      () => EditTextField(
                    keyboardType: TextInputType.name,
                    editingController: medicineOrderController.nameController,
                    labelText: 'enter_message_title'.tr,
                    errorText: medicineOrderController.isNameError.value
                        ? 'save_as_error'.tr
                        : null,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        medicineOrderController.isNameError.value = false;
                      }
                    },
                  ),
                ),

                if (medicineOrderController.type == 1) Spacer(),

                if (medicineOrderController.type == 1)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${'total_mrp'.tr} ",
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.regular,
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                          Spacer(),
                          Obx(
                                () => Text(
                              '${medicineOrderController.mrp.value}$CURRENCY',
                              // '${medicineOrderController.price % 2 == 0 ?
                              // medicineOrderController.price.toString().split(".").first : medicineOrderController.price}$CURRENCY',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                fontSize: 14,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ),
                        ],
                      ),
                      5.hs,
                      if (medicineOrderController.isMedicine.toString() == "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${'delivery_charges'.tr} ",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '+${medicineOrderController.delivery.value}$CURRENCY',
                              // "+${(double.parse(deliveryCharge) ?? 0.0).toStringAsFixed(1)}$CURRENCY",
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                fontSize: 14,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ],
                        ),
                      if (medicineOrderController.isMedicine.toString() == "2")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              medicineOrderController.isChargeName.tr,
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '+${medicineOrderController.isChargeValue}$CURRENCY',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.regular,
                                fontSize: 14,
                                color: AppColors.BLACK,
                              ),
                            ),
                          ],
                        ),
                      5.hs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${'tax'.tr} ",
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.regular,
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '+${medicineOrderController.tax.value}%',

                            // "+${(double.parse(tax) ?? 0.0).toStringAsFixed(1)}%",
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.regular,
                              fontSize: 14,
                              color: AppColors.BLACK,
                            ),
                          ),
                        ],
                      ),
                      5.hs,
                      Divider(
                        thickness: 1,
                      ),
                      5.hs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${'total_price1'.tr}",
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.semiBold,
                              fontSize: 19,
                              color: AppColors.reportTextColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(medicineOrderController.price.value % 2 == 0 ? medicineOrderController.price.value.toStringAsFixed(1) : medicineOrderController.price.value.toStringAsFixed(1))}$CURRENCY",
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: AppFontStyleTextStrings.regular,
                              fontSize: 19,
                              color: AppColors.color1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
