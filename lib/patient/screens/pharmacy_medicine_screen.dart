import 'package:flutter/cupertino.dart';
import 'package:videocalling_medical/common/model/cart_medicine_model.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class PharmacyMedicineScreen extends GetView<PharmacyMedicineController> {
  final PharmacyMedicineController pharmacyMedicineController =
  Get.put(PharmacyMedicineController());

  @override
  Widget build(BuildContext context) {
    // ViewCartController cartController = ViewCartController();
    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: AppBar(
        leading: Container(),
        elevation: 0.0,
        backgroundColor: AppColors.transparentColor,
        toolbarHeight:
        Platform.isIOS ? kToolbarHeight + 25 : kToolbarHeight + 25,
        flexibleSpace: Obx(() =>
            CustomSearchScreenAppBar2(
              title: ''.tr,
              title1: ''.tr,
              hintText: pharmacyMedicineController.page.value == "1"
                  ? 'search_medicine_hint'.tr
                  : 'search_report_hint'.tr,
              textController:
              pharmacyMedicineController.searchMedicineController,
              valueColor: pharmacyMedicineController.isLoading.value
                  ? AlwaysStoppedAnimation(Theme
                  .of(context)
                  .hintColor)
                  : AlwaysStoppedAnimation(AppColors.transparentColor),
              onSubmitted: (value) async {
                Get.focusScope?.unfocus();
                if (pharmacyMedicineController.searchMedicineController.text
                    .toString() ==
                    "" ||
                    pharmacyMedicineController.searchMedicineController.text ==
                        null) {
                  if (pharmacyMedicineController.page.value == "1") {
                    await pharmacyMedicineController.callMostUsedMedicineApi();
                  } else {
                    await pharmacyMedicineController.callMostUsedReportApi();
                  }
                } else {
                  if (pharmacyMedicineController.page.value == "1") {
                    pharmacyMedicineController.searchMedicineApi(
                        medicineName: value);
                  } else {
                    pharmacyMedicineController.searchReportApi(
                        medicineName: value);
                  }
                }
              },
              onPressed: () async {
                Get.focusScope?.unfocus();
                if (pharmacyMedicineController.searchMedicineController.text
                    .toString() ==
                    null ||
                    pharmacyMedicineController.searchMedicineController.text
                        .toString() ==
                        '') {
                  await pharmacyMedicineController.callMostUsedMedicineApi();
                }

                if (pharmacyMedicineController.page.value == "1") {
                  pharmacyMedicineController.searchMedicineApi(
                      medicineName: pharmacyMedicineController
                          .searchMedicineController.text);
                } else {
                  pharmacyMedicineController.searchReportApi(
                      medicineName: pharmacyMedicineController
                          .searchMedicineController.text);
                }
              },
              isBackArrow: true,
              onPressed1: () => Get.back(),
            )),
      ),
      bottomNavigationBar: Obx(() =>
      !pharmacyMedicineController.loadMore.value
          ? 0.hs
          : const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: LinearProgressIndicator(
          color: AppColors.color1,
          backgroundColor: AppColors.color2,
        ),
      )),
      body: Obx(
            () =>
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      pharmacyMedicineController.isSearch.value
                          ? !pharmacyMedicineController
                          .isLoadingSearchMedicine.value
                          ? SizedBox(
                        height: Get.height * 0.3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : pharmacyMedicineController.ll.isEmpty
                          ? Container(
                        height: Get.height * 0.3,
                        alignment: Alignment.center,
                        child: AppTextWidgets.regularText(
                          text: 'data_not_found'.tr,
                          color: AppColors.BLACK,
                          size: 18,
                        ),
                      )

                      ///pharmacyMedicineController.ll.length
                      ///search data
                          : Obx(() {
                        return Expanded(
                          child: ListView.builder(
                            controller: pharmacyMedicineController
                                .allMedicineScrollController,
                            itemCount: pharmacyMedicineController.ll.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  if (pharmacyMedicineController
                                      .processedIndices.contains(
                                      int.parse(
                                          pharmacyMedicineController.ll[index]
                                              .id.toString()))) {
                                    return pharmacyMedicineController
                                        .showToastMessage(
                                        msg: pharmacyMedicineController.page
                                            .value == "1"
                                            ? 'already_added'.tr
                                            : 'already_added_report'.tr);
                                  }
                                  // Add the index to the processed set
                                  pharmacyMedicineController.processedIndices
                                      .add(int.parse(
                                      pharmacyMedicineController.ll[index].id
                                          .toString()));

                                  pharmacyMedicineController.itemcount.value =
                                      pharmacyMedicineController.itemcount
                                          .value + 1;
                                  pharmacyMedicineController
                                      .mostUsedMedicineCheak[index] == true
                                      ? pharmacyMedicineController.cnt.value--
                                      : pharmacyMedicineController.cnt.value++;
                                  pharmacyMedicineController
                                      .mostUsedMedicineCheak[index] =
                                  !pharmacyMedicineController
                                      .mostUsedMedicineCheak[index];

                                  List<CartMedicine> cartData = await Get.find<
                                      DBHelperCart>().getCartList();
                                  bool? st = false;
                                  if (cartData.isNotEmpty &&
                                      cartData.first.pId != int.parse(
                                          pharmacyMedicineController.id)) {
                                    st = await medicineCartDialog();
                                    if (st ?? false) {
                                      await Get.find<DBHelperCart>()
                                          .truncateTable();
                                    } else {
                                      st = false;
                                    }
                                  } else {
                                    st = true;
                                  }
                                  if (st ?? false) {
                                    for (int i = 0; i <
                                        pharmacyMedicineController.ll
                                            .length; i++) {
                                      if (pharmacyMedicineController
                                          .mostUsedMedicineCheak[i]) {
                                        await DBHelperCart().save(
                                          CartMedicine(
                                            price: "${pharmacyMedicineController
                                                .ll[i].price}",
                                            name: pharmacyMedicineController
                                                .ll[i].name,
                                            mId: pharmacyMedicineController
                                                .ll[i].id,
                                            description: pharmacyMedicineController
                                                .ll[i].description,
                                            image: pharmacyMedicineController
                                                .ll[i].image,
                                            pId: int.parse(
                                                pharmacyMedicineController.id),
                                            isMedicine: pharmacyMedicineController
                                                .page.value == "1" ? 1 : 2,
                                          ),
                                        );
                                      }
                                    }
                                    pharmacyMedicineController
                                        .mostUsedMedicineCheak.value =
                                        List.filled(
                                            pharmacyMedicineController.ll
                                                .length, false);
                                    Get.delete<ViewCartController>();
                                    pharmacyMedicineController.getCartLength();
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.WHITE,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      const SizedBox(width: 12),
                                      if (pharmacyMedicineController.page
                                          .value == "1")
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Container(
                                            width: 105,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.greyShade3),
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                            ),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              margin: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 0, horizontal: 0),
                                              child: pharmacyMedicineController
                                                  .ll[index].image == "null"
                                                  ? Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  color: Color(0xFFEEEEEE),
                                                ),
                                                child: Opacity(
                                                  opacity: 0.60,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
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
                                                borderRadius: BorderRadius
                                                    .circular(12),
                                                child: Image.network(
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                  "${Apis
                                                      .medicineImage}${pharmacyMedicineController
                                                      .ll[index].image}",
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(AppImages
                                                        .medicine1);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (pharmacyMedicineController.page
                                          .value == "1")
                                        const SizedBox(width: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              if (pharmacyMedicineController
                                                  .page.value == "2")
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        pharmacyMedicineController
                                                            .ll[index].name ??
                                                            "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: AppFontStyleTextStrings
                                                              .medium,
                                                          color: AppColors
                                                              .reportTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(right: 10.0),
                                                      child: Text(
                                                        (pharmacyMedicineController
                                                            .ll[index].price!)
                                                            .toStringAsFixed(
                                                            1) +
                                                            CURRENCY,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontFamily: AppFontStyleTextStrings
                                                              .medium,
                                                          fontSize: 15,
                                                          color: AppColors
                                                              .color1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Text(
                                                  pharmacyMedicineController
                                                      .ll[index].name ?? "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: AppFontStyleTextStrings
                                                        .medium,
                                                    color: AppColors
                                                        .reportTextColor,
                                                  ),
                                                ),
                                              const SizedBox(height: 4),
                                              if (pharmacyMedicineController
                                                  .page.value == "2")
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(right: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          pharmacyMedicineController
                                                              .ll[index]
                                                              .description
                                                              ?.toString() ??
                                                              "",
                                                          style: TextStyle(
                                                            fontFamily: AppFontStyleTextStrings
                                                                .medium,
                                                            fontSize: 10,
                                                            color: AppColors
                                                                .LIGHT_GREY_TEXT,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .color1,
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8.0),
                                                          child: Obx(() {
                                                            return Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(
                                                                    pharmacyMedicineController
                                                                        .processedIndices
                                                                        .contains(
                                                                        int
                                                                            .parse(
                                                                            pharmacyMedicineController
                                                                                .ll[index]
                                                                                .id
                                                                                .toString()))
                                                                        ? 'added'
                                                                        .tr
                                                                        : 'add_to_cart2'
                                                                        .tr,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    style: TextStyle(
                                                                      fontFamily:
                                                                      AppFontStyleTextStrings
                                                                          .regular,
                                                                      fontSize: 14,
                                                                      color: AppColors
                                                                          .WHITE,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  Image.asset(
                                                                    AppImages
                                                                        .carticon,
                                                                    height: 22,
                                                                    color: AppColors
                                                                        .WHITE,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Text(
                                                  (pharmacyMedicineController
                                                      .ll[index].price!)
                                                      .toStringAsFixed(1) +
                                                      CURRENCY,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: AppFontStyleTextStrings
                                                        .medium,
                                                    fontSize: 15,
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                              const SizedBox(height: 4),
                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Container(
                                                  height: 35,
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.color1,
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Obx(() {
                                                      return Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              pharmacyMedicineController
                                                                  .processedIndices
                                                                  .contains(
                                                                  int.parse(
                                                                      pharmacyMedicineController
                                                                          .ll[index]
                                                                          .id
                                                                          .toString()))
                                                                  ? 'added'.tr
                                                                  : 'add_to_cart2'
                                                                  .tr,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                AppFontStyleTextStrings
                                                                    .regular,
                                                                fontSize: 14,
                                                                color: AppColors
                                                                    .WHITE,
                                                              ),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Image.asset(
                                                              AppImages
                                                                  .carticon,
                                                              height: 22,
                                                              color: AppColors
                                                                  .WHITE,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                          : !pharmacyMedicineController
                          .isMostUsedMedicineLoaded.value
                          ? SizedBox(
                        height: Get.height * 0.3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : pharmacyMedicineController
                          .mostUsedMedicineList.isEmpty
                          ? Container(
                        height: Get.height * 0.3,
                        alignment: Alignment.center,
                        child: AppTextWidgets.regularText(
                          text: 'data_not_found'.tr,
                          color: AppColors.BLACK,
                          size: 18,
                        ),
                      )
                          : Obx(() {
                        return Expanded(
                          child: ListView.builder(
                            controller: pharmacyMedicineController
                                .allMedicineScrollController,
                            itemCount: pharmacyMedicineController
                                .mostUsedMedicineList.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  if (pharmacyMedicineController
                                      .processedIndices
                                      .contains(int.parse(
                                      pharmacyMedicineController
                                          .mostUsedMedicineList[
                                      index]
                                          .id
                                          .toString()))) {
                                    return pharmacyMedicineController
                                        .showToastMessage(
                                        msg: pharmacyMedicineController
                                            .page.value ==
                                            "1"
                                            ? 'already_added'.tr
                                            : 'already_added_report'
                                            .tr);
                                  }
                                  // Add the index to the processed set
                                  pharmacyMedicineController
                                      .processedIndices
                                      .add(int.parse(
                                      pharmacyMedicineController
                                          .mostUsedMedicineList[
                                      index]
                                          .id
                                          .toString()));

                                  pharmacyMedicineController
                                      .itemcount.value =
                                      pharmacyMedicineController
                                          .itemcount.value +
                                          1;
                                  pharmacyMedicineController
                                      .mostUsedMedicineCheak[
                                  index] ==
                                      true
                                      ? pharmacyMedicineController
                                      .cnt.value--
                                      : pharmacyMedicineController
                                      .cnt.value++;
                                  pharmacyMedicineController
                                      .mostUsedMedicineCheak[
                                  index] =
                                  !pharmacyMedicineController
                                      .mostUsedMedicineCheak[
                                  index];

                                  List<CartMedicine> cartData =
                                  await Get.find<DBHelperCart>()
                                      .getCartList();
                                  bool? st = false;
                                  if (cartData.isNotEmpty &&
                                      cartData.first.pId !=
                                          int.parse(
                                              pharmacyMedicineController
                                                  .id)) {
                                    st = await medicineCartDialog();
                                    if (st ?? false) {
                                      await Get.find<DBHelperCart>()
                                          .truncateTable();
                                    } else {
                                      st = false;
                                    }
                                  } else {
                                    st = true;
                                  }
                                  if (st ?? false) {
                                    {
                                      for (int i = 0;
                                      i <
                                          pharmacyMedicineController
                                              .mostUsedMedicineList
                                              .length;
                                      i++) {
                                        if (pharmacyMedicineController
                                            .mostUsedMedicineCheak[
                                        i]) {
                                          await DBHelperCart().save(
                                            CartMedicine(
                                              price:
                                              "${pharmacyMedicineController
                                                  .mostUsedMedicineList[i]
                                                  .price}",
                                              name: pharmacyMedicineController
                                                  .mostUsedMedicineList[
                                              i]
                                                  .name,
                                              mId: pharmacyMedicineController
                                                  .mostUsedMedicineList[
                                              i]
                                                  .id,
                                              description:
                                              pharmacyMedicineController
                                                  .mostUsedMedicineList[
                                              i]
                                                  .description,
                                              image: pharmacyMedicineController
                                                  .mostUsedMedicineList[
                                              i]
                                                  .image,
                                              pId: int.parse(
                                                  pharmacyMedicineController
                                                      .id),
                                              isMedicine: pharmacyMedicineController
                                                  .page.value ==
                                                  "1" ? 1 : 2,
                                            ),
                                          );
                                        }
                                      }
                                      pharmacyMedicineController
                                          .mostUsedMedicineCheak
                                          .value =
                                          List.filled(
                                              pharmacyMedicineController
                                                  .mostUsedMedicineList
                                                  .length,
                                              false);
                                      Get.delete<ViewCartController>();
                                      pharmacyMedicineController
                                          .getCartLength();
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      0, 5, 0, 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.WHITE,
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      if (pharmacyMedicineController
                                          .page.value ==
                                          "1")...[
                                        Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              vertical: 12.0),
                                          child: Container(
                                            width: 105,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors
                                                    .greyShade3,
                                              ),
                                              borderRadius:
                                              BorderRadius
                                                  .circular(12),
                                            ),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              margin: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 0,
                                                  horizontal: 0),
                                              child: pharmacyMedicineController
                                                  .mostUsedMedicineList[
                                              index]
                                                  .image ==
                                                  "null"
                                                  ? Container(
                                                alignment:
                                                Alignment
                                                    .center,
                                                decoration:
                                                BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      12),
                                                  color: Color(
                                                      0xFFEEEEEE),
                                                ),
                                                child: Opacity(
                                                  opacity: 0.60,
                                                  child:
                                                  ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    child: Image
                                                        .asset(
                                                      AppImages
                                                          .medicine1,
                                                      fit: BoxFit
                                                          .contain,
                                                      height:
                                                      50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    12),
                                                child: Image
                                                    .network(
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit
                                                      .cover,
                                                  "${Apis
                                                      .medicineImage}${pharmacyMedicineController
                                                      .mostUsedMedicineList[index]
                                                      .image}",
                                                  errorBuilder:
                                                      (context,
                                                      error,
                                                      stackTrace) {
                                                    return Image
                                                        .asset(
                                                      AppImages
                                                          .medicine1,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],


                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 12.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              if (pharmacyMedicineController
                                                  .page.value == "2")
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        pharmacyMedicineController
                                                            .mostUsedMedicineList[
                                                        index]
                                                            .name ??
                                                            "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                    Text(
                                                      (pharmacyMedicineController
                                                          .mostUsedMedicineList[
                                                      index]
                                                          .price!)
                                                          .toStringAsFixed(
                                                          1) +
                                                          CURRENCY,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        AppFontStyleTextStrings
                                                            .medium,
                                                        fontSize: 15,
                                                        color:
                                                        AppColors.color1,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Text(
                                                  pharmacyMedicineController
                                                      .mostUsedMedicineList[
                                                  index]
                                                      .name ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily:
                                                    AppFontStyleTextStrings
                                                        .medium,
                                                    color: AppColors
                                                        .reportTextColor,
                                                  ),
                                                ),

                                              const SizedBox(
                                                  height: 4),

                                              if (pharmacyMedicineController
                                                  .page.value == "2")
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(right: .0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          pharmacyMedicineController
                                                              .mostUsedMedicineList![index]
                                                              .description!
                                                              .toString(),
                                                          // maxLines: 2,
                                                          style: TextStyle(
                                                            fontFamily:
                                                            AppFontStyleTextStrings
                                                                .medium,
                                                            fontSize: 10,
                                                            color: AppColors
                                                                .LIGHT_GREY_TEXT,
                                                          ),
                                                        ),
                                                      ),
                                                      Obx(() {
                                                        return Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color:

                                                              pharmacyMedicineController
                                                                  .processedIndices
                                                                  .value
                                                                  .contains(
                                                                  int.parse(
                                                                      pharmacyMedicineController
                                                                          .mostUsedMedicineList[
                                                                      index]
                                                                          .id
                                                                          .toString()))
                                                                  ?
                                                              AppColors
                                                                  .color1
                                                                  .withOpacity(
                                                                  0.5)
                                                                  : AppColors
                                                                  .color1,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                8.0),
                                                            child: Obx(() {
                                                              return Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Text(
                                                                      pharmacyMedicineController
                                                                          .processedIndices
                                                                          .value
                                                                          .contains(
                                                                          int
                                                                              .parse(
                                                                              pharmacyMedicineController
                                                                                  .mostUsedMedicineList[
                                                                              index]
                                                                                  .id
                                                                                  .toString()))
                                                                          ? 'add_to_cart2'
                                                                          .tr
                                                                          : 'add_to_cart2'
                                                                          .tr,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style:
                                                                      TextStyle(
                                                                        fontFamily:
                                                                        AppFontStyleTextStrings
                                                                            .regular,
                                                                        fontSize:
                                                                        14,
                                                                        color: AppColors
                                                                            .WHITE,
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      })
                                                    ],
                                                  ),
                                                ),

                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Text(
                                                  (pharmacyMedicineController
                                                      .mostUsedMedicineList[
                                                  index]
                                                      .price!)
                                                      .toStringAsFixed(
                                                      1) +
                                                      CURRENCY,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    AppFontStyleTextStrings
                                                        .medium,
                                                    fontSize: 15,
                                                    color:
                                                    AppColors.grey,
                                                  ),
                                                ),


                                              const SizedBox(
                                                  height: 4),

                                              if (pharmacyMedicineController
                                                  .page.value == "1")
                                                Container(
                                                  height: 35,
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .color1,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        8.0),
                                                    child: Obx(() {
                                                      return Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              pharmacyMedicineController
                                                                  .processedIndices
                                                                  .value
                                                                  .contains(
                                                                  int.parse(
                                                                      pharmacyMedicineController
                                                                          .mostUsedMedicineList[
                                                                      index]
                                                                          .id
                                                                          .toString()))
                                                                  ? 'added'
                                                                  .tr
                                                                  : 'add_to_cart2'
                                                                  .tr,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style:
                                                              TextStyle(
                                                                fontFamily:
                                                                AppFontStyleTextStrings
                                                                    .regular,
                                                                fontSize:
                                                                14,
                                                                color: AppColors
                                                                    .WHITE,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            // Spacer(),
                                                            Image.asset(
                                                              AppImages
                                                                  .carticon,
                                                              height:
                                                              22,
                                                              color: AppColors
                                                                  .WHITE,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                      ),

                                      if (pharmacyMedicineController
                                          .page.value ==
                                          "2")
                                        const SizedBox(
                                          width: 12,
                                        ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),

                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 57,
                    margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: InkWell(
                      onTap: () async {
                        print(pharmacyMedicineController.homeCharge);
                        print(pharmacyMedicineController.labCharge);


                        final result = await Get.to(
                          ViewCartScreen(),
                        );
                        if (result != null) {
                          pharmacyMedicineController.getCartLength();
                          pharmacyMedicineController.update();
                        }
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.color1,
                                    AppColors.color2,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              height: 60,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                            ),
                          ),
                          Center(
                            child:
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 5, 20, 5),
                                  child: Obx(() {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            AppTextWidgets.mediumText(
                                              text:
                                              "${pharmacyMedicineController
                                                  .cartLength.value} ",
                                              color: AppColors.WHITE,
                                              size: 18,
                                            ),
                                            AppTextWidgets.mediumText(
                                              text: 'item'.tr,
                                              color: AppColors.WHITE,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                        AppTextWidgets.mediumText(
                                          text: 'view_cart1'.tr,
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
                                Expanded(child: 0.ws),
                                AppTextWidgets.mediumText(
                                  text: 'checkout'.tr,
                                  color: AppColors.WHITE,
                                  size: 16,
                                ),
                                3.ws,
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.WHITE,
                                  size: 16,
                                ),
                                12.ws,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
