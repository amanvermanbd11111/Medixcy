import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class SpecialityScreen extends GetView<SpecialityController> {
  final SpecialityController specialityController =
      Get.put(SpecialityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120), // ⬅️ Increased height
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: MedixyAppBar(
            title: 'Medixcy',
            onPressed: () => Get.back(),
            isBackArrow: true,
            searchController: specialityController.searchController,
            onSearchChanged: specialityController.onSearchChanged,
            searchHint: "Search Specialization",
          ),
          leading: Container(),
        ),
      ),
      body: Obx(() => specialityController.isErrorInLoading.value
          ? Center(
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
            )
          : specialityController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const ClampingScrollPhysics(),
                      //   itemCount: specialityController.list.length > 4
                      //       ? (specialityController.list.length / 4).ceil()
                      //       : 1,
                      //   itemBuilder: (context, i) {
                      //     return Column(
                      //       children: [
                      //         GridView.count(
                      //           padding:
                      //               const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //           crossAxisCount: 2,
                      //           shrinkWrap: true,
                      //           crossAxisSpacing: 8,
                      //           mainAxisSpacing: 8,
                      //           physics: const ClampingScrollPhysics(),
                      //           children: List.generate(4, (index) {
                      //             return InkWell(
                      //               onTap: () async {
                      //                 if (index + (i * 4) <=
                      //                     specialityController.list.length -
                      //                         1) {
                      //                   await Get.toNamed(
                      //                     Routes.specialityDoctorScreen,
                      //                     arguments: {
                      //                       'id': specialityController
                      //                           .list[index + (i * 4)].id
                      //                           .toString(),
                      //                       'name': specialityController
                      //                           .list[index + (i * 4)].name
                      //                           .toString(),
                      //                     },
                      //                   );
                      //                   Get.delete<
                      //                       SpecialityDoctorController>();
                      //                 }
                      //               },
                      //               child: index + (i * 4) >
                      //                       specialityController.list.length - 1
                      //                   ? Container()
                      //                   : Stack(
                      //                       children: [
                      //                         Column(
                      //                           children: [
                      //                             Expanded(
                      //                               child: Image.asset(
                      //                                 AppImages.specialityBg,
                      //                                 fit: BoxFit.fill,
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                         Container(
                      //                           padding:
                      //                               const EdgeInsets.all(15),
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Container(
                      //                                 height: 70,
                      //                                 width: 70,
                      //                                 decoration: BoxDecoration(
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(10),
                      //                                 ),
                      //                                 padding:
                      //                                     const EdgeInsets.all(
                      //                                         13),
                      //                                 child: Image.network(
                      //                                   specialityController
                      //                                       .list[
                      //                                           index + (i * 4)]
                      //                                       .icon!,
                      //                                   height: 50,
                      //                                   width: 50,
                      //                                 ),
                      //                               ),
                      //                               const SizedBox(
                      //                                 height: 10,
                      //                               ),
                      //                               AppTextWidgets.mediumText(
                      //                                 text: specialityController
                      //                                         .list[index +
                      //                                             (i * 4)]
                      //                                         .name ??
                      //                                     "",
                      //                                 maxline: 2,
                      //                                 color: AppColors.BLACK,
                      //                                 size: 15,
                      //                               ),
                      //                               AppTextWidgets.mediumText(
                      //                                 text: specialityController
                      //                                         .list[index +
                      //                                             (i * 4)]
                      //                                         .totalDoctors
                      //                                         .toString() +
                      //                                     "specialist".tr,
                      //                                 color: AppColors
                      //                                     .LIGHT_GREY_TEXT,
                      //                                 size: 13,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //             );
                      //           }),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),

                    ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: specialityController.filteredList.length,
                    itemBuilder: (context, index) {
                      final speciality = specialityController.filteredList[index];
                      return InkWell(
                        onTap: () async {
                          await Get.toNamed(
                            Routes.specialityDoctorScreen,
                            arguments: {
                              'id': speciality.id.toString(),
                              'name': speciality.name.toString(),
                            },
                          );
                          Get.delete<SpecialityDoctorController>();
                        },
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.teal.shade100,
                              thickness: 2,
                              height: 0,
                              // indent: 16,
                              // endIndent: 16,
                            ),
                            Container(
                              //margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.circular(10),
                              //   border: Border.all(color: Colors.teal.shade100, width: 1),
                              // ),
                              child: Row(
                                children: [
                                  // Circle Icon
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.teal.shade200, width: 1),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      speciality.icon ?? "",
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported, color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(width: 15),

                                  // Texts
                                  Expanded(
                                    child: Text(
                                      speciality.name ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  //const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
        ],
                  ),
                )),
    );
  }
}
