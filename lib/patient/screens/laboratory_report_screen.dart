import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/main.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class LaboratoryReportScreen extends GetView<UserPastAppointmentsController> {
  final UserPastAppointmentsController pharmacyOrderController =
      Get.put(UserPastAppointmentsController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      body:
      Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          // controller: pharmacyOrderController.scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              5.hs,
              Obx(
                    () => pharmacyOrderController.isErrorInLoading2.value
                    ? SizedBox(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        20.hs,
                        Icon(
                          Icons.search_off_rounded,
                          size: 100,
                          color: AppColors.LIGHT_GREY_TEXT,
                        ),
                        10.hs,
                        Text(
                          'unable_to_load_data'.tr,
                          style: const TextStyle(
                            fontFamily: AppFontStyleTextStrings.regular,
                          ),
                        ),
                        20.hs,
                      ],
                    ),
                  ),
                )
                    : pharmacyOrderController.isLoaded2.value
                    ? pharmacyOrderController.isAppointmentExist2.value
                    ? ListView.builder(
                      itemCount: pharmacyOrderController.reportList.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (pharmacyOrderController.reportList.length == index) {
                          return const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: LinearProgressIndicator(),
                          );
                        }
                        else {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Get.toNamed(Routes.uAppointmentDetailScreen, arguments: {
                                "id": pharmacyOrderController.reportList[index].id.toString(),
                                "bool": labKey,

                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.WHITE,
                                ),
                                child: Row(
                                  children: [
                                    pharmacyOrderController.reportList[index].laboratoryImage
                                        .toString() !=
                                        ""
                                        ? Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(8),
                                        // border: Border.all(color: AppColors.greyShade3)
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: pharmacyOrderController
                                              .reportList[index].laboratoryImage!,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) => Container(
                                            color: Theme.of(context).primaryColorLight,
                                            child: Image.asset(
                                              AppImages.tab3dUnselect,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                          errorWidget: (context, url, err) => Container(
                                              color: Theme.of(context).primaryColorLight,
                                              child: Image.asset(
                                                AppImages.tab3dUnselect,
                                                height: 20,
                                                width: 20,
                                              )),
                                        ),
                                      ),
                                    )
                                        : Container(
                                        color: Theme.of(context).primaryColorLight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image.asset(
                                            AppImages.tab3dUnselect,
                                            height: 20,
                                            width: 20,
                                          ),
                                        )),
                                    10.ws,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AppTextWidgets.mediumText(
                                                text:
                                                "${'order_id'.tr}${pharmacyOrderController.reportList[index].id.toString() ?? ""}",
                                                color: AppColors.color1,
                                                size: 14,
                                              ),
                                              2.hs,
                                              AppTextWidgets.semiBoldText(
                                                text: pharmacyOrderController
                                                    .reportList[index].laboratoryName
                                                    .toString() ??
                                                    "",
                                                color: AppColors.BLACK,
                                                size: 13,
                                              ),
                                              2.hs,
                                              Text(
                                                pharmacyOrderController
                                                    .reportList[index].laboratoryAddress ??
                                                    "",
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: AppFontStyleTextStrings.medium,
                                                  color: AppColors.LIGHT_GREY_TEXT,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.ws,
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          AppImages.calender,
                                          height: 17,
                                          width: 17,
                                        ),
                                        5.hs,
                                        AppTextWidgets.regularText(
                                          text:
                                          "${pharmacyOrderController.reportList[index].createdAt?.substring(8, 10)}"
                                              "${pharmacyOrderController.reportList[index].createdAt?.substring(4, 8)}"
                                              "${pharmacyOrderController.reportList[index].createdAt?.substring(0, 4)}",
                                          color: AppColors.LIGHT_GREY_TEXT,
                                          size: 11,
                                        ),
                                        Row(
                                          children: [
                                            AppTextWidgets.regularText(
                                              text:
                                              "${pharmacyOrderController.reportList[index].createdAt?.substring(11, 16)}",
                                              color: AppColors.BLACK,
                                              size: 15,
                                            ),
                                            if(pharmacyOrderController.ampm1!= null)
                                              AppTextWidgets.regularText(
                                                text:
                                                " ${pharmacyOrderController.ampm1![index]}",
                                                color: AppColors.BLACK,
                                                size: 15,
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                    : Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(30.0),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.noAppointment,
                      ),
                      15.hs,
                      AppTextWidgets.blackTextWithSize(
                        text: 'not_appointment1'.tr,
                        size: 11,
                      ),
                      3.hs,
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppTextWidgets.mediumTextWithSize(
                            text: 'not_appointment2'.tr,
                            size: 10,
                          ),
                          3.hs,
                          InkWell(
                            onTap: () async {
                              await Get.toNamed(
                                  Routes.specialityScreen);
                              Get.delete<SpecialityController>();
                            },
                            child: AppTextWidgets.blackText(
                              text: 'not_appointment3'.tr,
                              size: 10,
                              color: AppColors.AMBER,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                    : SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
