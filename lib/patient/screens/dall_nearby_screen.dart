import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import '../../common/screens/city_sorting_screen.dart';

class DAllNearbyScreen extends GetView<DAllNearbyController> {
  final DAllNearbyController nearbyController = Get.put(DAllNearbyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        flexibleSpace: Obx(() {
          print("${nearbyController.selected_city_name.value}");
          return CustomAppBar(
            title: nearbyController.page == 2
                ? 'pharmacy'.tr
                : nearbyController.page == 3
                ? 'Laboratory'.tr
                : 'nearby_doctors'.tr,
            isTitle2:
            (nearbyController.selected_city_name.value.toString() == 0 ||
                nearbyController.selected_city_name.value.toString() ==
                    "" ||
                nearbyController.selected_city_name.value.toString() ==
                    "not")
                ? false
                : true,

            title2: "${nearbyController.selected_city_name.value}",

            isBackArrow: true,
            sortIcon: true,
            onPressedClear: () async {
              Get.to(CitySortingScreen())!.then((cityId) {
                if (cityId != null) {
                  nearbyController.selected_city =
                      cityId.toString(); // Update the selected city ID
                  nearbyController.selected_city_name.value =
                      StorageService.readData(
                          key: LocalStorageKeys.sortCityName) ??
                          "not";
                  refreshScreen(nearbyController.selected_city!);
                }
              });
            },

            onPressed: () => Get.back(),
          );
        }),
      ),
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      body: Obx(() => nearbyController.isErrorInLoading.value
          ? Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 100,
                color: AppColors.LIGHT_GREY_TEXT,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'unable_to_load_data'.tr,
                style: const TextStyle(
                  fontFamily: AppFontStyleTextStrings.regular,
                ),
              )
            ],
          ),
        ),
      )
          : SingleChildScrollView(
          controller: nearbyController.scrollController,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                nearbyController.isNearbyLoading.value
                    ? SizedBox(
                  height: Get.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : (nearbyController.page == 2 ||
                    nearbyController.page == 3
                    ? nearbyController.list1.isEmpty
                    : nearbyController.list.isEmpty)
                    ? nearbyController.isErrorInNearby.value
                    ? Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextWidgets.regularText(
                          text:
                          'data_not_found'.tr,
                          size: 12,
                          color: AppColors.BLACK),
                    ],
                  ),
                )
                    : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).hintColor),
                    strokeWidth: 2,
                  ),
                )
                    :

                GridView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: nearbyController.page == 2 ||
                      nearbyController.page == 3
                      ? nearbyController.list1.length
                      : nearbyController.list.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return DoctorGrid(
                      onTap: () async {
                        await Get.toNamed(
                            Routes.doctorDetailScreen,
                            arguments: {
                              'id': nearbyController.page == 2 ||
                                  nearbyController.page == 3
                                  ? nearbyController
                                  .list1[index].id
                                  .toString()
                                  : nearbyController
                                  .list[index].id
                                  .toString(),
                              'type': nearbyController.page
                            });

                        Get.delete<DoctorDetailController>();
                      },
                      type: nearbyController.page,
                      name: nearbyController.page == 2 ||
                          nearbyController.page == 3
                          ? nearbyController.list1[index].name ??
                          ""
                          : nearbyController.list[index].name ??
                          "",
                      departmentName:
                      nearbyController.page == 2 ||
                          nearbyController.page == 3
                          ? nearbyController
                          .list1[index].address ??
                          ""
                          : nearbyController.list[index]
                          .departmentName ??
                          "",
                      imgPath: nearbyController.page == 2 ||
                          nearbyController.page == 3
                          ? nearbyController.list1[index].image ??
                          ""
                          : nearbyController.list[index].image ??
                          "",
                    );
                  },
                ),
                nearbyController.isLoadingMore.value
                    ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: LinearProgressIndicator(),
                )
                    : Container(
                  height: 10,
                )
              ],
            ),
          ))),
    );
  }

  void refreshScreen(String cityId) {
    print("cityId");
    print("nearbyController.selected_city");
    print(cityId);
    print(nearbyController.selected_city);

    nearbyController.page == 2 || nearbyController.page == 3
        ? nearbyController.list1.clear()
        : nearbyController.list.clear();

    if (nearbyController.page == 2) {
      nearbyController.callPharmacyApi(
          latitude: double.parse(latitude.toString()),
          longitude: double.parse(longitude.toString()),
          cityId: cityId);
    } else if (nearbyController.page == 3) {

      print("object call laboratory api");

      nearbyController.callLaboratoryApi(
          latitude: double.parse(latitude.toString()),
          longitude: double.parse(longitude.toString()),
          cityId: cityId);
    } else {
      nearbyController.callApi(
        latitude: double.parse(latitude.toString()),
        longitude: double.parse(longitude.toString()),
        cityId: cityId,
      );
    }
  }
}
