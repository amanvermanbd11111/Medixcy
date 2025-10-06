import 'package:videocalling_medical/common/screens/city_sorting_screen.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import '../../common/screens/ai_chat_screen.dart';

class UserHomeScreen extends GetView<UserHomeController> {
  final UserHomeController homeController = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    List NameList = [
      'Doctor'.tr,
      'Pharmacy'.tr,
      'Laboratory'.tr,
      'Specialty'.tr,
      'AI Chat'.tr,
      'Doctor Chat'.tr,
      // 'Sort By City'.tr,
    ];

    List IconList = [
      'assets/new_icon/doctor.png',
      'assets/new_icon/pharmacy.png',
      'assets/new_icon/pharmacy.png', // laboratory image
      'assets/new_icon/speciality.png',
      'assets/new_icon/ai_chat.png',
      'assets/new_icon/doctor_chat.png',
      // 'assets/new_icon/sort_by_city.png',
    ];

    return Scaffold(

      ///before
     // backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
     //  appBar: AppBar(
     //    leading: Container(),
     //    backgroundColor: AppColors.transparentColor,
     //    toolbarHeight: kToolbarHeight + 70,
     //    flexibleSpace: Obx(() => CustomHomeScreenAppBar(
     //      title: 'welcome_str'.tr,
     //      title1: StorageService.readData(key: LocalStorageKeys.name) ??
     //          'user_str'.tr,
     //      textController: homeController.textController,
     //      valueColor: homeController.isSearching.value &&
     //          !homeController.isSearchDataLoaded.value
     //          ? AlwaysStoppedAnimation(Theme.of(context).hintColor)
     //          : AlwaysStoppedAnimation(AppColors.transparentColor),
     //      onChanged: (val) {
     //        homeController.searchKeyword.value = val;
     //        homeController.onChanged(val);
     //      },
     //      onSubmitted: (val) {
     //        homeController.searchKeyword.value = val;
     //      },
     //      onPressed: () async {
     //        Get.focusScope?.unfocus();
     //        await Get.toNamed(Routes.dSearchScreen,
     //            arguments: {'keyword': homeController.textController.text});
     //        Get.delete<DoctorSearchController>();
     //        homeController.newData.clear();
     //        homeController.textController.clear();
     //        homeController.searchKeyword.value = "";
     //        homeController.update();
     //
     //        if (homeController.searchKeyword.isEmpty &&
     //            homeController.isSearching.value) {
     //          homeController.newData.clear();
     //          homeController.isSearching.value = false;
     //          homeController.pageController.previousPage(
     //            duration: const Duration(milliseconds: 850),
     //            curve: Curves.linear,
     //          );
     //        }
     //      },
     //      onPressedSort: () async {
     //        String selected_city =
     //            "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //        String selected_city_n =
     //            "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //
     //        homeController.selectedCityIndex.value =
     //            int.parse(selected_city.toString()) - 1;
     //        homeController.selectedIndex.value = false;
     //
     //        Get.to(CitySortingScreen())!.then((cityId) {
     //          print("cityId==> $cityId");
     //          if (cityId != null) {
     //            homeController.callApi(
     //                latitude: double.parse(latitude.toString()),
     //                longitude: double.parse(longitude.toString()),
     //                cityId: cityId.toString());
     //          }
     //        });
     //      },
     //    )),
     //  ),
     //  body: Obx(
     //        () => PageView(
     //      controller: homeController.pageController,
     //      physics: const NeverScrollableScrollPhysics(),
     //      children: [
     //        SingleChildScrollView(
     //          controller: homeController.scrollController2,
     //          child: Column(
     //            children: [
     //              /// new code add 6 grid ui
     //              Padding(
     //                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
     //                child: Column(
     //                  crossAxisAlignment: CrossAxisAlignment.start,
     //                  children: [
     //                    GridView.builder(
     //                      itemCount: NameList.length,
     //                      shrinkWrap: true,
     //                      physics: const NeverScrollableScrollPhysics(),
     //                      // Prevent scroll conflict
     //                      gridDelegate:
     //                      const SliverGridDelegateWithFixedCrossAxisCount(
     //                        crossAxisCount: 3, // 3 per row
     //                        crossAxisSpacing: 10,
     //                        mainAxisSpacing: 10,
     //                        childAspectRatio: 1.7,
     //                      ),
     //                      itemBuilder: (context, index) {
     //                        return GestureDetector(
     //                          onTap: () async {
     //                            // doctor list
     //                            if (index == 0) {
     //                              Get.focusScope?.unfocus();
     //                              await Get.toNamed(
     //                                Routes.dAllNearbyScreen,
     //                                arguments: {'page': 1},
     //                              )!
     //                                  .then(
     //                                    (value) {
     //                                  String selected_city =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //                                  String selected_city_n =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //
     //                                  homeController.callApi(
     //                                      latitude:
     //                                      double.parse(latitude.toString()),
     //                                      longitude: double.parse(
     //                                          longitude.toString()),
     //                                      cityId: selected_city);
     //                                },
     //                              );
     //                              Get.delete<DAllNearbyController>();
     //                            }
     //                            // pharmacy list
     //                            else if (index == 1) {
     //                              Get.focusScope?.unfocus();
     //                              await Get.toNamed(
     //                                Routes.dAllNearbyScreen,
     //                                arguments: {'page': 2},
     //                              )!
     //                                  .then(
     //                                    (value) {
     //                                  String selected_city =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //
     //                                  String selected_city_n =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //                                  homeController.callApi(
     //                                      latitude:
     //                                      double.parse(latitude.toString()),
     //                                      longitude: double.parse(
     //                                          longitude.toString()),
     //                                      cityId: selected_city);
     //                                },
     //                              );
     //                              Get.delete<DAllNearbyController>();
     //                            }
     //                            // laboratory list
     //                            else if (index == 2) {
     //                              print("object");
     //                              print("object 123456");
     //                              Get.focusScope?.unfocus();
     //                              await Get.toNamed(
     //                                Routes.dAllNearbyScreen,
     //                                arguments: {'page': 3},
     //                              )!
     //                                  .then(
     //                                    (value) {
     //                                  String selected_city =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //
     //                                  String selected_city_n =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //                                  homeController.callApi(
     //                                      latitude:
     //                                      double.parse(latitude.toString()),
     //                                      longitude: double.parse(
     //                                          longitude.toString()),
     //                                      cityId: selected_city);
     //                                },
     //                              );
     //                              Get.delete<DAllNearbyController>();
     //                            }
     //                            // speciality
     //                            else if (index == 3) {
     //                              Get.focusScope?.unfocus();
     //                              await Get.toNamed(Routes.specialityScreen)!
     //                                  .then(
     //                                    (value) {
     //                                  String selected_city =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //                                  String selected_city_n =
     //                                      "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //
     //                                  homeController.callApi(
     //                                      latitude:
     //                                      double.parse(latitude.toString()),
     //                                      longitude: double.parse(
     //                                          longitude.toString()),
     //                                      cityId: selected_city);
     //                                },
     //                              );
     //                              Get.delete<SpecialityController>();
     //                            }
     //                            // ai chat
     //                            else if (index == 4) {
     //                              Get.to(AiChatScreen());
     //                            }
     //                            // doctor chat
     //                            else if (index == 5) {
     //                              PatientTabController tabController =
     //                              Get.put(PatientTabController());
     //                              tabController.index.value = 3;
     //                            }
     //                            // city sorting
     //                            else if (index == 6) {
     //                              String selected_city =
     //                                  "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //                              homeController.selectedCityIndex.value =
     //                                  int.parse(selected_city.toString()) - 1;
     //                              homeController.selectedIndex.value = false;
     //                              Get.to(CitySortingScreen())!.then((cityId) {
     //                                print("cityId==> $cityId");
     //                                if (cityId != null) {
     //                                  homeController.callApi(
     //                                      latitude:
     //                                      double.parse(latitude.toString()),
     //                                      longitude: double.parse(
     //                                          longitude.toString()),
     //                                      cityId: cityId.toString());
     //                                }
     //                              });
     //                            }
     //                          },
     //                          child: Container(
     //                            decoration: BoxDecoration(
     //                              color: AppColors.WHITE,
     //                              borderRadius: BorderRadius.circular(15),
     //                            ),
     //                            padding:
     //                            const EdgeInsets.symmetric(horizontal: 8),
     //                            child: Center(
     //                              child: Column(
     //                                mainAxisAlignment: MainAxisAlignment.center,
     //                                children: [
     //                                  const SizedBox(height: 8),
     //                                  SizedBox(
     //                                    height: 26,
     //                                    width: 26,
     //                                    child: Image.asset(
     //                                      "${IconList[index]}",
     //                                    ),
     //                                  ),
     //                                  const SizedBox(width: 8),
     //                                  Expanded(
     //                                    child: Text(
     //                                      '${NameList[index]}',
     //                                      textAlign: TextAlign.start,
     //                                      style: const TextStyle(
     //                                        fontFamily:
     //                                        AppFontStyleTextStrings.medium,
     //                                        color: AppColors.BLACK,
     //                                        fontSize: 14,
     //                                      ),
     //                                      maxLines: 2,
     //                                      overflow: TextOverflow.ellipsis,
     //                                    ),
     //                                  ),
     //                                  const SizedBox(height: 8),
     //                                ],
     //                              ),
     //                            ),
     //                          ),
     //                        );
     //                      },
     //                    ),
     //                  ],
     //                ),
     //              ),
     //
     //              Obx(() => homeController.isErrorInLoading.value
     //                  ? Center(
     //                child: Column(
     //                  crossAxisAlignment: CrossAxisAlignment.center,
     //                  mainAxisAlignment: MainAxisAlignment.center,
     //                  children: [
     //                    20.hs,
     //                    Icon(
     //                      Icons.search_off_rounded,
     //                      size: 100,
     //                      color: AppColors.LIGHT_GREY_TEXT,
     //                    ),
     //                    10.hs,
     //                    Text(
     //                      'unable_to_load_data'.tr,
     //                      style: const TextStyle(
     //                        fontFamily: AppFontStyleTextStrings.regular,
     //                      ),
     //                    ),
     //                    20.hs,
     //                  ],
     //                ),
     //              )
     //                  : homeController.isDataLoaded.value
     //                  ? Column(
     //                children: [
     //                  ///hide slider with image
     //                  // Padding(
     //                  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
     //                  //   child: Container(
     //                  //     decoration: BoxDecoration(
     //                  //       borderRadius: BorderRadius.circular(15),
     //                  //     ),
     //                  //     child: CarouselSlider.builder(
     //                  //       carouselController: homeController.sliderController,
     //                  //       itemCount: homeController.bannerList.length,
     //                  //       itemBuilder: (context, index, realIndex) {
     //                  //         return Padding(
     //                  //           padding: const EdgeInsets.all(8.0),
     //                  //           child: Stack(
     //                  //             children: [
     //                  //               GestureDetector(
     //                  //                 onTap: () {
     //                  //                   if(index+1 == homeController.bannerList.length){
     //                  //                     Get.to(AiChatScreen());
     //                  //                   }
     //                  //                 },
     //                  //                 child: CachedNetworkImage(
     //                  //                   imageUrl: (Apis.IMAGE + homeController.bannerList[index].image!),
     //                  //                   fit: BoxFit.cover,
     //                  //                   imageBuilder: (context, imageProvider) {
     //                  //                     return Container(
     //                  //                       decoration: BoxDecoration(
     //                  //                           borderRadius: BorderRadius.circular(15),
     //                  //                           image: DecorationImage(
     //                  //                             image: imageProvider,
     //                  //                             fit: BoxFit.fill,
     //                  //                           )),
     //                  //                     );
     //                  //                   },
     //                  //                   placeholder: (context, url) => Container(
     //                  //                     height: 220,
     //                  //                     decoration: BoxDecoration(
     //                  //                       borderRadius: BorderRadius.circular(15),
     //                  //                       image: const DecorationImage(
     //                  //                         image: AssetImage(AppImages.sliderPlaceholder),
     //                  //                         fit: BoxFit.cover,
     //                  //                       ),
     //                  //                     ),
     //                  //                   ),
     //                  //                   errorWidget: (context, url, err) => Container(
     //                  //                     height: 220,
     //                  //                     decoration: BoxDecoration(
     //                  //                       borderRadius: BorderRadius.circular(15),
     //                  //                       image: const DecorationImage(
     //                  //                         image: AssetImage(
     //                  //                           AppImages.sliderError,
     //                  //                         ),
     //                  //                         fit: BoxFit.cover,
     //                  //                       ),
     //                  //                     ),
     //                  //                   ),
     //                  //                 ),
     //                  //               ),
     //                  //
     //                  //               // Align(
     //                  //               //   alignment: Alignment.bottomCenter,
     //                  //               //   child: Padding(
     //                  //               //     padding: const EdgeInsets.all(8.0),
     //                  //               //     child: Row(
     //                  //               //         mainAxisAlignment: MainAxisAlignment.center,
     //                  //               //         children: homeController.bannerList.asMap().entries.map((entry) {
     //                  //               //           return GestureDetector(
     //                  //               //               child: Container(
     //                  //               //             width: 12.0,
     //                  //               //             height: 12.0,
     //                  //               //             margin: const EdgeInsets.symmetric(
     //                  //               //                 vertical: 8.0, horizontal: 4.0),
     //                  //               //             decoration: BoxDecoration(
     //                  //               //               shape: BoxShape.circle,
     //                  //               //               color: homeController.current.value == entry.key
     //                  //               //                   ? AppColors.BLACK
     //                  //               //                   : AppColors.greyShade3,
     //                  //               //             ),
     //                  //               //           ));
     //                  //               //         }).toList()),
     //                  //               //   ),
     //                  //               // )
     //                  //
     //                  //             ],
     //                  //           ),
     //                  //         );
     //                  //       },
     //                  //       options: CarouselOptions(
     //                  //         viewportFraction: 1,
     //                  //         height: Get.width * 0.55,
     //                  //         initialPage: 0,
     //                  //         reverse: false,
     //                  //         autoPlay: true,
     //                  //         onPageChanged: (index, reason) {
     //                  //           homeController.current.value = index;
     //                  //         },
     //                  //       ),
     //                  //     ),
     //                  //   ),
     //                  // ),
     //
     //                  ///old code upcoming appointment
     //                  // homeController.isLoggedIn.value
     //                  //     ? Container(
     //                  //         margin: const EdgeInsets.fromLTRB(
     //                  //             16, 0, 16, 0),
     //                  //         child: Column(
     //                  //           mainAxisSize: MainAxisSize.min,
     //                  //           mainAxisAlignment:
     //                  //               MainAxisAlignment.start,
     //                  //           children: [
     //                  //             Row(
     //                  //               mainAxisAlignment:
     //                  //                   MainAxisAlignment
     //                  //                       .spaceBetween,
     //                  //               children: [
     //                  //                 Text('upcoming_appointments'.tr,
     //                  //                     style: Theme.of(context)
     //                  //                         .textTheme
     //                  //                         .bodyMedium!
     //                  //                         .apply(
     //                  //                             fontWeightDelta:
     //                  //                                 3)),
     //                  //                 homeController.appointmentList
     //                  //                         .isNotEmpty
     //                  //                     ? TextButton(
     //                  //                         onPressed: () async {
     //                  //                           Get.focusScope
     //                  //                               ?.unfocus();
     //                  //                           await Get.toNamed(Routes
     //                  //                               .uAllAppointmentsScreen);
     //                  //                           Get.delete<
     //                  //                               UAllAppointmentsController>();
     //                  //                         },
     //                  //                         child: Text(
     //                  //                             'see_all'.tr,
     //                  //                             style: Theme.of(
     //                  //                                     context)
     //                  //                                 .textTheme
     //                  //                                 .bodyLarge!
     //                  //                                 .apply(
     //                  //                                   color: Theme.of(
     //                  //                                           context)
     //                  //                                       .hintColor,
     //                  //                                 )),
     //                  //                       )
     //                  //                     : Container(
     //                  //                         height: 40,
     //                  //                       )
     //                  //               ],
     //                  //             ),
     //                  //
     //                  //
     //                  //             homeController
     //                  //                     .appointmentList.isEmpty
     //                  //                 ? Container(
     //                  //                     width:
     //                  //                         MediaQuery.of(context)
     //                  //                             .size
     //                  //                             .width,
     //                  //                     decoration: BoxDecoration(
     //                  //                         color: Theme.of(context)
     //                  //                             .scaffoldBackgroundColor,
     //                  //                         borderRadius:
     //                  //                             BorderRadius
     //                  //                                 .circular(15)),
     //                  //                     child: Padding(
     //                  //                       padding:
     //                  //                           const EdgeInsets.all(
     //                  //                               30.0),
     //                  //                       child: Column(
     //                  //                         children: [
     //                  //                           Image.asset(AppImages
     //                  //                               .noAppointment),
     //                  //                           const SizedBox(
     //                  //                             height: 15,
     //                  //                           ),
     //                  //                           AppTextWidgets
     //                  //                               .blackTextWithSize(
     //                  //                             text:
     //                  //                                 'not_appointment1'
     //                  //                                     .tr,
     //                  //                             size: 11,
     //                  //                           ),
     //                  //                           const SizedBox(
     //                  //                             height: 3,
     //                  //                           ),
     //                  //                           Row(
     //                  //                             mainAxisAlignment:
     //                  //                                 MainAxisAlignment
     //                  //                                     .center,
     //                  //                             children: [
     //                  //                               Container(
     //                  //                                 width:
     //                  //                                     (Get.width -
     //                  //                                             95) *
     //                  //                                         0.75,
     //                  //                                 alignment: Alignment
     //                  //                                     .centerRight,
     //                  //                                 child: Text(
     //                  //                                   'not_appointment2'
     //                  //                                       .tr,
     //                  //                                   overflow:
     //                  //                                       TextOverflow
     //                  //                                           .ellipsis,
     //                  //                                   maxLines: 1,
     //                  //                                   style: const TextStyle(
     //                  //                                       fontFamily:
     //                  //                                           AppFontStyleTextStrings
     //                  //                                               .medium,
     //                  //                                       fontSize:
     //                  //                                           10),
     //                  //                                 ),
     //                  //                               ),
     //                  //                               const SizedBox(
     //                  //                                 width: 3,
     //                  //                               ),
     //                  //                               InkWell(
     //                  //                                 onTap:
     //                  //                                     () async {
     //                  //                                   Get.focusScope
     //                  //                                       ?.unfocus();
     //                  //                                   await Get.toNamed(
     //                  //                                       Routes
     //                  //                                           .specialityScreen);
     //                  //                                   Get.delete<
     //                  //                                       SpecialityController>();
     //                  //                                 },
     //                  //                                 child: SizedBox(
     //                  //                                   width: (Get.width -
     //                  //                                           95) *
     //                  //                                       0.25,
     //                  //                                   child: AppTextWidgets.blackText(
     //                  //                                       text: 'not_appointment3'
     //                  //                                           .tr,
     //                  //                                       size: 10,
     //                  //                                       color: AppColors
     //                  //                                           .AMBER),
     //                  //                                 ),
     //                  //                               ),
     //                  //                             ],
     //                  //                           ),
     //                  //                         ],
     //                  //                       ),
     //                  //                     ),
     //                  //                   )
     //                  //                 : ListView.builder(
     //                  //                     itemCount: homeController
     //                  //                                 .appointmentList
     //                  //                                 .length >
     //                  //                             2
     //                  //                         ? 2
     //                  //                         : homeController
     //                  //                             .appointmentList
     //                  //                             .length,
     //                  //                     shrinkWrap: true,
     //                  //                     padding:
     //                  //                         const EdgeInsets.all(0),
     //                  //                     physics:
     //                  //                         const ClampingScrollPhysics(),
     //                  //                     itemBuilder:
     //                  //                         (context, index) {
     //                  //                       return InkWell(
     //                  //                         borderRadius:
     //                  //                             BorderRadius
     //                  //                                 .circular(15),
     //                  //                         onTap: () {
     //                  //                           Get.focusScope
     //                  //                               ?.unfocus();
     //                  //                           Get.toNamed(
     //                  //                               Routes
     //                  //                                   .uAppointmentDetailScreen,
     //                  //                               arguments: {
     //                  //                                 'id': homeController
     //                  //                                     .appointmentList[
     //                  //                                         index]
     //                  //                                     .id
     //                  //                                     .toString()
     //                  //                               });
     //                  //                         },
     //                  //                         child: Container(
     //                  //                           height: 90,
     //                  //                           margin:
     //                  //                               const EdgeInsets
     //                  //                                   .fromLTRB(
     //                  //                                   0, 5, 0, 5),
     //                  //                           padding:
     //                  //                               const EdgeInsets
     //                  //                                   .all(8),
     //                  //                           decoration:
     //                  //                               BoxDecoration(
     //                  //                             borderRadius:
     //                  //                                 BorderRadius
     //                  //                                     .circular(
     //                  //                                         10),
     //                  //                             color:
     //                  //                                 AppColors.WHITE,
     //                  //                           ),
     //                  //                           child: Row(
     //                  //                             children: [
     //                  //                               ClipRRect(
     //                  //                                 borderRadius:
     //                  //                                     BorderRadius
     //                  //                                         .circular(
     //                  //                                             15),
     //                  //                                 child:
     //                  //                                     CachedNetworkImage(
     //                  //                                   imageUrl:
     //                  //                                       "${Apis.doctorImagePath}${homeController.appointmentList[index].doctorls!.image}",
     //                  //                                   height: 70,
     //                  //                                   width: 70,
     //                  //                                   fit: BoxFit
     //                  //                                       .cover,
     //                  //                                   placeholder: (context,
     //                  //                                           url) =>
     //                  //                                       Container(
     //                  //                                     color: Theme.of(
     //                  //                                             context)
     //                  //                                         .primaryColorLight,
     //                  //                                     child:
     //                  //                                         Padding(
     //                  //                                       padding: const EdgeInsets
     //                  //                                           .all(
     //                  //                                           20.0),
     //                  //                                       child: Image
     //                  //                                           .asset(
     //                  //                                         AppImages
     //                  //                                             .tab3dUnselect,
     //                  //                                         height:
     //                  //                                             20,
     //                  //                                         width:
     //                  //                                             20,
     //                  //                                       ),
     //                  //                                     ),
     //                  //                                   ),
     //                  //                                   errorWidget: (context,
     //                  //                                           url,
     //                  //                                           err) =>
     //                  //                                       Container(
     //                  //                                           color: Theme.of(context)
     //                  //                                               .primaryColorLight,
     //                  //                                           child:
     //                  //                                               Padding(
     //                  //                                             padding:
     //                  //                                                 const EdgeInsets.all(20.0),
     //                  //                                             child:
     //                  //                                                 Image.asset(
     //                  //                                               AppImages.tab3dUnselect,
     //                  //                                               height: 20,
     //                  //                                               width: 20,
     //                  //                                             ),
     //                  //                                           )),
     //                  //                                 ),
     //                  //                               ),
     //                  //                               const SizedBox(
     //                  //                                 width: 10,
     //                  //                               ),
     //                  //                               Expanded(
     //                  //                                 child: Column(
     //                  //                                   mainAxisAlignment:
     //                  //                                       MainAxisAlignment
     //                  //                                           .center,
     //                  //                                   crossAxisAlignment:
     //                  //                                       CrossAxisAlignment
     //                  //                                           .start,
     //                  //                                   children: [
     //                  //                                     Column(
     //                  //                                       crossAxisAlignment:
     //                  //                                           CrossAxisAlignment
     //                  //                                               .start,
     //                  //                                       children: [
     //                  //                                         AppTextWidgets
     //                  //                                             .mediumText(
     //                  //                                           text: homeController.appointmentList[index].doctorls!.name ??
     //                  //                                               "",
     //                  //                                           color:
     //                  //                                               AppColors.BLACK,
     //                  //                                           size:
     //                  //                                               13,
     //                  //                                         ),
     //                  //                                         AppTextWidgets.regularText(
     //                  //                                             text: homeController.appointmentList[index].departmentName ??
     //                  //                                                 "",
     //                  //                                             size:
     //                  //                                                 11,
     //                  //                                             color:
     //                  //                                                 AppColors.BLACK),
     //                  //                                       ],
     //                  //                                     ),
     //                  //                                     5.hs,
     //                  //                                     Text(
     //                  //                                       homeController
     //                  //                                               .appointmentList[index]
     //                  //                                               .doctorls!
     //                  //                                               .address ??
     //                  //                                           "",
     //                  //                                       maxLines:
     //                  //                                           2,
     //                  //                                       overflow:
     //                  //                                           TextOverflow
     //                  //                                               .ellipsis,
     //                  //                                       style: TextStyle(
     //                  //                                           color: AppColors
     //                  //                                               .LIGHT_GREY_TEXT,
     //                  //                                           fontSize:
     //                  //                                               10,
     //                  //                                           fontFamily:
     //                  //                                               AppFontStyleTextStrings.regular),
     //                  //                                     ),
     //                  //                                   ],
     //                  //                                 ),
     //                  //                               ),
     //                  //                               const SizedBox(
     //                  //                                 width: 10,
     //                  //                               ),
     //                  //                               Column(
     //                  //                                 mainAxisAlignment:
     //                  //                                     MainAxisAlignment
     //                  //                                         .center,
     //                  //                                 crossAxisAlignment:
     //                  //                                     CrossAxisAlignment
     //                  //                                         .end,
     //                  //                                 children: [
     //                  //                                   Image.asset(
     //                  //                                     AppImages
     //                  //                                         .calender,
     //                  //                                     height: 17,
     //                  //                                     width: 17,
     //                  //                                   ),
     //                  //                                   const SizedBox(
     //                  //                                     height: 5,
     //                  //                                   ),
     //                  //                                   AppTextWidgets.regularText(
     //                  //                                       text:
     //                  //                                           "${homeController.appointmentList[index].date.toString().substring(8)}-${homeController.appointmentList[index].date.toString().substring(5, 7)}-${homeController.appointmentList[index].date.toString().substring(0, 4)}",
     //                  //                                       size: 11,
     //                  //                                       color: AppColors
     //                  //                                           .LIGHT_GREY_TEXT),
     //                  //                                   AppTextWidgets
     //                  //                                       .mediumText(
     //                  //                                     text: homeController
     //                  //                                             .appointmentList[index]
     //                  //                                             .slot ??
     //                  //                                         "",
     //                  //                                     color: AppColors
     //                  //                                         .BLACK,
     //                  //                                     size: 15,
     //                  //                                   ),
     //                  //                                 ],
     //                  //                               ),
     //                  //                             ],
     //                  //                           ),
     //                  //                         ),
     //                  //                       );
     //                  //                     },
     //                  //                   )
     //                  //           ],
     //                  //         ),
     //                  //       )
     //                  //     : Container(),
     //
     //                  /// new code Hide upcoming appointment section if no appointments
     //                  homeController.isLoggedIn.value
     //                      ? Container(
     //                    margin: const EdgeInsets.fromLTRB(
     //                        16, 0, 16, 0),
     //                    child: Column(
     //                      mainAxisSize: MainAxisSize.min,
     //                      mainAxisAlignment:
     //                      MainAxisAlignment.start,
     //                      children: [
     //                        Row(
     //                          mainAxisAlignment:
     //                          MainAxisAlignment
     //                              .spaceBetween,
     //                          children: [
     //                            homeController
     //                                .appointmentList.isEmpty
     //                                ? Container()
     //                                : Text(
     //                                'upcoming_appointments'
     //                                    .tr,
     //                                style: Theme.of(context)
     //                                    .textTheme
     //                                    .bodyMedium!
     //                                    .apply(
     //                                    fontWeightDelta:
     //                                    3)),
     //                            homeController.appointmentList
     //                                .isNotEmpty
     //                                ? TextButton(
     //                              onPressed: () async {
     //                                Get.focusScope
     //                                    ?.unfocus();
     //                                await Get.toNamed(Routes
     //                                    .uAllAppointmentsScreen);
     //
     //                                Get.delete<UAllAppointmentsController>();
     //                              },
     //                              child: Text(
     //                                  'see_all'.tr,
     //                                  style: Theme.of(
     //                                      context)
     //                                      .textTheme
     //                                      .bodyLarge!
     //                                      .apply(
     //                                    color: Theme.of(
     //                                        context)
     //                                        .hintColor,
     //                                  )),
     //                            )
     //                                : homeController
     //                                .appointmentList
     //                                .isEmpty
     //                                ? Container()
     //                                : Container(
     //                              height: 40,
     //                            )
     //                          ],
     //                        ),
     //                        homeController
     //                            .appointmentList.isEmpty
     //                            ? Container()
     //                            : ListView.builder(
     //                          itemCount: homeController
     //                              .appointmentList
     //                              .length >
     //                              2
     //                              ? 2
     //                              : homeController
     //                              .appointmentList
     //                              .length,
     //                          shrinkWrap: true,
     //                          padding:
     //                          const EdgeInsets.all(0),
     //                          physics:
     //                          const ClampingScrollPhysics(),
     //                          itemBuilder:
     //                              (context, index) {
     //                            return InkWell(
     //                              borderRadius:
     //                              BorderRadius
     //                                  .circular(15),
     //                              onTap: () {
     //                                Get.focusScope
     //                                    ?.unfocus();
     //                                Get.toNamed(
     //                                    Routes
     //                                        .uAppointmentDetailScreen,
     //                                    arguments: {
     //                                      'id': homeController
     //                                          .appointmentList[
     //                                      index]
     //                                          .id
     //                                          .toString()
     //                                    });
     //                              },
     //                              child: Container(
     //                                height: 90,
     //                                margin:
     //                                const EdgeInsets
     //                                    .fromLTRB(
     //                                    0, 5, 0, 5),
     //                                padding:
     //                                const EdgeInsets
     //                                    .all(8),
     //                                decoration:
     //                                BoxDecoration(
     //                                  borderRadius:
     //                                  BorderRadius
     //                                      .circular(
     //                                      10),
     //                                  color:
     //                                  AppColors.WHITE,
     //                                ),
     //                                child: Row(
     //                                  children: [
     //                                    ClipRRect(
     //                                      borderRadius:
     //                                      BorderRadius
     //                                          .circular(
     //                                          15),
     //                                      child:
     //                                      CachedNetworkImage(
     //                                        imageUrl:
     //                                        "${Apis.doctorImagePath}${homeController.appointmentList[index].doctorls!.image}",
     //                                        height: 70,
     //                                        width: 70,
     //                                        fit: BoxFit
     //                                            .cover,
     //                                        placeholder: (context,
     //                                            url) =>
     //                                            Container(
     //                                              color: Theme.of(
     //                                                  context)
     //                                                  .primaryColorLight,
     //                                              child:
     //                                              Padding(
     //                                                padding: const EdgeInsets
     //                                                    .all(
     //                                                    20.0),
     //                                                child: Image
     //                                                    .asset(
     //                                                  AppImages
     //                                                      .tab3dUnselect,
     //                                                  height:
     //                                                  20,
     //                                                  width:
     //                                                  20,
     //                                                ),
     //                                              ),
     //                                            ),
     //                                        errorWidget: (context,
     //                                            url,
     //                                            err) =>
     //                                            Container(
     //                                                color: Theme.of(context)
     //                                                    .primaryColorLight,
     //                                                child:
     //                                                Padding(
     //                                                  padding:
     //                                                  const EdgeInsets.all(20.0),
     //                                                  child:
     //                                                  Image.asset(
     //                                                    AppImages.tab3dUnselect,
     //                                                    height: 20,
     //                                                    width: 20,
     //                                                  ),
     //                                                )),
     //                                      ),
     //                                    ),
     //                                    const SizedBox(
     //                                      width: 10,
     //                                    ),
     //                                    Expanded(
     //                                      child: Column(
     //                                        mainAxisAlignment:
     //                                        MainAxisAlignment
     //                                            .center,
     //                                        crossAxisAlignment:
     //                                        CrossAxisAlignment
     //                                            .start,
     //                                        children: [
     //                                          Column(
     //                                            crossAxisAlignment:
     //                                            CrossAxisAlignment
     //                                                .start,
     //                                            children: [
     //                                              AppTextWidgets
     //                                                  .mediumText(
     //                                                text: homeController.appointmentList[index].doctorls!.name ??
     //                                                    "",
     //                                                maxline:
     //                                                2,
     //                                                color:
     //                                                AppColors.BLACK,
     //                                                size:
     //                                                13,
     //                                              ),
     //                                              AppTextWidgets.regularText(
     //                                                  text: homeController.appointmentList[index].departmentName ??
     //                                                      "",
     //                                                  size:
     //                                                  11,
     //                                                  maxLine:
     //                                                  1,
     //                                                  color:
     //                                                  AppColors.BLACK),
     //                                            ],
     //                                          ),
     //                                          5.hs,
     //                                          Text(
     //                                            homeController
     //                                                .appointmentList[index]
     //                                                .doctorls!
     //                                                .address ??
     //                                                "",
     //                                            maxLines:
     //                                            1,
     //                                            overflow:
     //                                            TextOverflow
     //                                                .ellipsis,
     //                                            style: TextStyle(
     //                                                color: AppColors
     //                                                    .LIGHT_GREY_TEXT,
     //                                                fontSize:
     //                                                10,
     //                                                fontFamily:
     //                                                AppFontStyleTextStrings.regular),
     //                                          ),
     //                                        ],
     //                                      ),
     //                                    ),
     //                                    const SizedBox(
     //                                      width: 10,
     //                                    ),
     //                                    Column(
     //                                      mainAxisAlignment:
     //                                      MainAxisAlignment
     //                                          .center,
     //                                      crossAxisAlignment:
     //                                      CrossAxisAlignment
     //                                          .end,
     //                                      children: [
     //                                        Image.asset(
     //                                          AppImages
     //                                              .calender,
     //                                          height: 17,
     //                                          width: 17,
     //                                        ),
     //                                        const SizedBox(
     //                                          height: 5,
     //                                        ),
     //                                        AppTextWidgets.regularText(
     //                                            text:
     //                                            "${homeController.appointmentList[index].date.toString().substring(8)}-${homeController.appointmentList[index].date.toString().substring(5, 7)}-${homeController.appointmentList[index].date.toString().substring(0, 4)}",
     //                                            size: 11,
     //                                            color: AppColors
     //                                                .LIGHT_GREY_TEXT),
     //                                        AppTextWidgets
     //                                            .mediumText(
     //                                          text: homeController
     //                                              .appointmentList[index]
     //                                              .slot ??
     //                                              "",
     //                                          color: AppColors
     //                                              .BLACK,
     //                                          size: 15,
     //                                        ),
     //                                      ],
     //                                    ),
     //                                  ],
     //                                ),
     //                              ),
     //                            );
     //                          },
     //                        )
     //                      ],
     //                    ),
     //                  )
     //                      : Container(),
     //
     //                  /// set grid
     //                  // Padding(
     //                  //   padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
     //                  //   child: Column(
     //                  //     crossAxisAlignment: CrossAxisAlignment.start,
     //                  //     children: [
     //                  //
     //                  //       GridView.builder(
     //                  //         itemCount: NameList.length,
     //                  //         shrinkWrap: true,
     //                  //         physics: const NeverScrollableScrollPhysics(), // Prevent scroll conflict
     //                  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
     //                  //           crossAxisCount: 3, // 3 per row
     //                  //           crossAxisSpacing: 10,
     //                  //           mainAxisSpacing: 10,
     //                  //           childAspectRatio: 1.8, // Adjust as needed
     //                  //         ),
     //                  //         itemBuilder: (context, index) {
     //                  //           return GestureDetector(
     //                  //             onTap: () async {
     //                  //               if(index == 0){    Get.focusScope?.unfocus();
     //                  //               await Get.toNamed(
     //                  //                 Routes.dAllNearbyScreen,
     //                  //                 arguments: {'page': 1},
     //                  //               )!.then((value) {
     //                  //                 String selected_city ="${StorageService.readData(
     //                  //                     key: LocalStorageKeys
     //                  //                         .sortCityId) ??
     //                  //                     "0"}";
     //                  //                 String selected_city_n ="${StorageService.readData(
     //                  //                     key: LocalStorageKeys
     //                  //                         .sortCityName) ??
     //                  //                     ""}";
     //                  //
     //                  //
     //                  //                 homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //
     //                  //               },);
     //                  //               Get.delete<DAllNearbyController>();}
     //                  //               else if(index == 1){
     //                  //
     //                  //                 Get.focusScope?.unfocus();
     //                  //                 await Get.toNamed(Routes.specialityScreen)!.then((value) {
     //                  //                   String selected_city ="${StorageService.readData(
     //                  //                       key: LocalStorageKeys
     //                  //                           .sortCityId) ??
     //                  //                       "0"}";
     //                  //                   String selected_city_n ="${StorageService.readData(
     //                  //                       key: LocalStorageKeys
     //                  //                           .sortCityName) ??
     //                  //                       ""}";
     //                  //
     //                  //                   homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //
     //                  //                 },);
     //                  //                 Get.delete<SpecialityController>();
     //                  //
     //                  //               }
     //                  //               else if(index == 2){
     //                  //                 Get.focusScope?.unfocus();
     //                  //                 await Get.toNamed(
     //                  //                   Routes.dAllNearbyScreen,
     //                  //                   arguments: {'page': 2},
     //                  //                 )!.then((value) {
     //                  //
     //                  //                   String selected_city ="${StorageService.readData(
     //                  //                       key: LocalStorageKeys
     //                  //                           .sortCityId) ??
     //                  //                       "0"}";
     //                  //
     //                  //                   String selected_city_n ="${StorageService.readData(
     //                  //                       key: LocalStorageKeys
     //                  //                           .sortCityName) ??
     //                  //                       ""}";
     //                  //                   homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //                 },);
     //                  //                 Get.delete<DAllNearbyController>();
     //                  //               }
     //                  //               else if(index == 3){
     //                  //                 Get.to(AiChatScreen());
     //                  //               }
     //                  //               else if(index == 4){
     //                  //                 PatientTabController tabController = Get.put(PatientTabController());
     //                  //                 tabController.index.value = 3 ;
     //                  //               }
     //                  //               else if(index == 5){
     //                  //                 String selected_city ="${StorageService.readData(
     //                  //                     key: LocalStorageKeys
     //                  //                         .sortCityId) ??
     //                  //                     "0"}";
     //                  //                 String selected_city_n ="${StorageService.readData(
     //                  //                     key: LocalStorageKeys
     //                  //                         .sortCityName) ??
     //                  //                     ""}";
     //                  //                 homeController.selectedCityIndex.value= int.parse(selected_city.toString())-1;
     //                  //
     //                  //                 Get.to(CitySortingScreen())!.then((cityId) {
     //                  //                   print("cityId==> $cityId");
     //                  //                   if (cityId != null) {
     //                  //
     //                  //                     homeController.callApi(
     //                  //                         latitude: double.parse(latitude.toString()),
     //                  //                         longitude: double.parse(longitude.toString()),
     //                  //                         cityId: cityId.toString());
     //                  //
     //                  //                     // homeController.callApi(cityId: cityId.toString());
     //                  //                   }
     //                  //                 });
     //                  //               }
     //                  //             },
     //                  //             child: Container(
     //                  //               decoration: BoxDecoration(
     //                  //                 color: AppColors.WHITE,
     //                  //                 borderRadius: BorderRadius.circular(15),
     //                  //               ),
     //                  //               padding: const EdgeInsets.symmetric(horizontal: 8),
     //                  //               child: Row(
     //                  //                 children: [
     //                  //                   SizedBox(
     //                  //                     height: 24,
     //                  //                     width: 24,
     //                  //                     child: Image.asset(
     //                  //                       "${IconList[index]}",
     //                  //                     ),
     //                  //                   ),
     //                  //                   const SizedBox(width: 8),
     //                  //                   Expanded(
     //                  //                     child: Text(
     //                  //                      '${NameList[index]}',
     //                  //                       textAlign: TextAlign.start,
     //                  //                       style: const TextStyle(
     //                  //                         fontFamily: AppFontStyleTextStrings.medium,
     //                  //                         color: AppColors.BLACK,
     //                  //                         fontSize: 12,
     //                  //                       ),
     //                  //                       maxLines: 2,
     //                  //                       overflow: TextOverflow.ellipsis,
     //                  //                     ),
     //                  //                   ),
     //                  //                 ],
     //                  //               ),
     //                  //             ),
     //                  //           );
     //                  //         },
     //                  //       ),
     //                  //     ],
     //                  //   ),
     //                  // ),
     //
     //                  /// old code with hide 3 options
     //                  // Padding(
     //                  //   padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
     //                  //   child: Row(
     //                  //     children: [
     //                  //       HomeGrid(
     //                  //         onTap: () async {
     //                  //           Get.focusScope?.unfocus();
     //                  //           await Get.toNamed(
     //                  //             Routes.dAllNearbyScreen,
     //                  //             arguments: {'page': 1},
     //                  //           )!.then((value) {
     //                  //             String selected_city ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityId) ??
     //                  //                 "0"}";
     //                  //             String selected_city_n ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityName) ??
     //                  //                 ""}";
     //                  //
     //                  //
     //                  //             homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //
     //                  //           },);
     //                  //           Get.delete<DAllNearbyController>();
     //                  //         },
     //                  //         text: 'doctors'.tr,
     //                  //       ),
     //                  //       10.ws,
     //                  //       HomeGrid(
     //                  //         onTap: () async {
     //                  //           Get.focusScope?.unfocus();
     //                  //           await Get.toNamed(Routes.specialityScreen)!.then((value) {
     //                  //             String selected_city ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityId) ??
     //                  //                 "0"}";
     //                  //             String selected_city_n ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityName) ??
     //                  //                 ""}";
     //                  //
     //                  //             homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //
     //                  //           },);
     //                  //           Get.delete<SpecialityController>();
     //                  //         },
     //                  //         text: 'speciality'.tr,
     //                  //       ),
     //                  //       10.ws,
     //                  //       HomeGrid(
     //                  //         onTap: () async {
     //                  //           Get.focusScope?.unfocus();
     //                  //           await Get.toNamed(
     //                  //             Routes.dAllNearbyScreen,
     //                  //             arguments: {'page': 2},
     //                  //           )!.then((value) {
     //                  //
     //                  //             String selected_city ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityId) ??
     //                  //                 "0"}";
     //                  //
     //                  //             String selected_city_n ="${StorageService.readData(
     //                  //                 key: LocalStorageKeys
     //                  //                     .sortCityName) ??
     //                  //                 ""}";
     //                  //             homeController.callApi(latitude: double.parse(latitude.toString()),longitude: double.parse(longitude.toString()),cityId: selected_city);
     //                  //           },);
     //                  //           Get.delete<DAllNearbyController>();
     //                  //         },
     //                  //         text: 'pharmacy'.tr,
     //                  //       ),
     //                  //     ],
     //                  //   ),
     //                  // )
     //                ],
     //              )
     //                  : Container(
     //                // height: Get.height * 0.35,
     //                  alignment: Alignment.center,
     //                  child: Container())),
     //
     //              Obx(() => homeController.isErrorInLoadDoctorData.value
     //                  ? Container()
     //                  : Column(
     //                children: [
     //                  Padding(
     //                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
     //                    child: Row(
     //                      mainAxisAlignment:
     //                      MainAxisAlignment.spaceBetween,
     //                      children: [
     //                        Text('nearby_doctors'.tr,
     //                            style: Theme.of(context)
     //                                .textTheme
     //                                .bodyMedium!
     //                                .apply(fontWeightDelta: 3)),
     //                        TextButton(
     //                          onPressed: () async {
     //                            Get.focusScope?.unfocus();
     //                            await Get.toNamed(
     //                              Routes.dAllNearbyScreen,
     //                              arguments: {'page': 1},
     //                            )!
     //                                .then(
     //                                  (value) {
     //                                // homeController.update();
     //                                String selected_city =
     //                                    "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
     //                                String selected_city_n =
     //                                    "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? ""}";
     //
     //                                homeController.callApi(
     //                                    latitude: double.parse(
     //                                        latitude.toString()),
     //                                    longitude: double.parse(
     //                                        longitude.toString()),
     //                                    cityId: selected_city);
     //                              },
     //                            );
     //                            Get.delete<DAllNearbyController>();
     //                          },
     //                          child: Text('see_all'.tr,
     //                              style: Theme.of(context)
     //                                  .textTheme
     //                                  .bodyLarge!
     //                                  .apply(
     //                                color:
     //                                Theme.of(context).hintColor,
     //                              )),
     //                        )
     //                      ],
     //                    ),
     //                  ),
     //                  Column(
     //                    children: [
     //                      const SizedBox(
     //                        height: 0,
     //                      ),
     //                      Container(
     //                        margin:
     //                        const EdgeInsets.fromLTRB(16, 0, 16, 5),
     //                        child: Column(
     //                          children: [
     //                            if (homeController.list2.isNotEmpty)
     //                              GridView.builder(
     //                                shrinkWrap: true,
     //                                physics:
     //                                const ClampingScrollPhysics(),
     //                                gridDelegate:
     //                                const SliverGridDelegateWithMaxCrossAxisExtent(
     //                                  maxCrossAxisExtent: 200,
     //                                  childAspectRatio: 0.75,
     //                                  crossAxisSpacing: 10,
     //                                  mainAxisSpacing: 10,
     //                                ),
     //                                itemCount:
     //                                homeController.list2.length,
     //                                itemBuilder:
     //                                    (BuildContext ctx, index) {
     //                                  var data =
     //                                  homeController.list2[index];
     //                                  return InkWell(
     //                                    onTap: () async {
     //                                      Get.focusScope?.unfocus();
     //                                      await Get.toNamed(
     //                                          Routes.doctorDetailScreen,
     //                                          arguments: {
     //                                            'id': data.id.toString(),
     //                                            'type': 1
     //                                          });
     //                                      Get.delete<
     //                                          DoctorDetailController>();
     //                                    },
     //                                    child: Container(
     //                                      decoration: BoxDecoration(
     //                                        color: AppColors.WHITE,
     //                                        borderRadius:
     //                                        BorderRadius.circular(15),
     //                                      ),
     //                                      padding:
     //                                      const EdgeInsets.fromLTRB(
     //                                          10, 10, 10, 20),
     //                                      child: Column(
     //                                        children: [
     //                                          Expanded(
     //                                            child: ClipRRect(
     //                                              borderRadius:
     //                                              BorderRadius
     //                                                  .circular(12),
     //                                              child:
     //                                              CachedNetworkImage(
     //                                                imageUrl:
     //                                                data.image ?? "",
     //                                                fit: BoxFit.cover,
     //                                                width: 250,
     //                                                placeholder:
     //                                                    (context, url) =>
     //                                                    Container(
     //                                                      color: Theme.of(
     //                                                          context)
     //                                                          .primaryColorLight,
     //                                                      child: Center(
     //                                                        child:
     //                                                        Image.asset(
     //                                                          AppImages
     //                                                              .tab3dUnselect,
     //                                                          height: 50,
     //                                                          width: 50,
     //                                                        ),
     //                                                      ),
     //                                                    ),
     //                                                errorWidget: (context,
     //                                                    url, err) =>
     //                                                    Container(
     //                                                      color: Theme.of(
     //                                                          context)
     //                                                          .primaryColorLight,
     //                                                      child: Center(
     //                                                        child:
     //                                                        Image.asset(
     //                                                          AppImages
     //                                                              .tab3dUnselect,
     //                                                          height: 50,
     //                                                          width: 50,
     //                                                        ),
     //                                                      ),
     //                                                    ),
     //                                              ),
     //                                            ),
     //                                          ),
     //                                          const SizedBox(
     //                                            height: 10,
     //                                          ),
     //                                          Text(
     //                                            data.name ?? "",
     //                                            maxLines: 2,
     //                                            textAlign:
     //                                            TextAlign.center,
     //                                            overflow:
     //                                            TextOverflow.ellipsis,
     //                                            style: const TextStyle(
     //                                              fontFamily:
     //                                              AppFontStyleTextStrings
     //                                                  .medium,
     //                                              color: AppColors.BLACK,
     //                                              fontSize: 13,
     //                                            ),
     //                                          ),
     //                                          AppTextWidgets.mediumText(
     //                                            text:
     //                                            data.departmentName ??
     //                                                "",
     //                                            color: AppColors
     //                                                .LIGHT_GREY_TEXT,
     //                                            size: 9.5,
     //                                          ),
     //                                        ],
     //                                      ),
     //                                    ),
     //                                  );
     //                                },
     //                              ),
     //                            // if(homeController.list2.isEmpty)
     //                            //   const Padding(
     //                            //     padding: EdgeInsets.only(top: 15),
     //                            //     child: CircularProgressIndicator(),
     //                            //   ),
     //                            // Container(
     //                            //   height: Get.height * 0.4,
     //                            //   alignment: Alignment.center,
     //                            //   child: AppTextWidgets.regularText(
     //                            //       text: 'doctor_not_found'.tr,
     //                            //       size: 20,
     //                            //       color: AppColors.BLACK),
     //                            // ),
     //                            homeController.nextUrlDoctor.value ==
     //                                "null"
     //                                ? Container()
     //                                : const Padding(
     //                              padding: EdgeInsets.only(top: 15),
     //                              child:
     //                              CircularProgressIndicator(),
     //                            ),
     //                          ],
     //                        ),
     //                      ),
     //                    ],
     //                  ),
     //                ],
     //              ))
     //            ],
     //          ),
     //        ),
     //        Padding(
     //          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
     //          child: Column(
     //            children: [
     //              !homeController.isSearchDataLoaded.value
     //                  ? 0.hs
     //                  : homeController.newData.isNotEmpty
     //                  ? 0.hs
     //                  : Padding(
     //                padding:
     //                const EdgeInsets.symmetric(vertical: 50.0),
     //                child: Center(
     //                  child: Text(
     //                    'doctor_not_found'.tr,
     //                    style: TextStyle(
     //                      fontFamily: AppFontStyleTextStrings.regular,
     //                      fontSize: 20,
     //                      color: homeController.newData.isEmpty
     //                          ? AppColors.BLACK
     //                          : AppColors.transparentColor,
     //                    ),
     //                  ),
     //                ),
     //              ),
     //
     //              ///search data in home page
     //              Expanded(
     //                child: ListView.separated(
     //                    controller: homeController.scrollController,
     //                    itemCount: homeController.newData.length,
     //                    separatorBuilder: (context, index) => const Divider(
     //                      endIndent: 7,
     //                      indent: 7,
     //                      thickness: 1,
     //                    ),
     //                    itemBuilder: (context, index) {
     //                      return InkWell(
     //                        onTap: () async {
     //                          await Get.toNamed(Routes.doctorDetailScreen,
     //                              arguments: {
     //                                'id': homeController.newData[index].id
     //                                    .toString(),
     //                                'type': 1
     //                              });
     //                          Get.delete<DoctorDetailController>();
     //                        },
     //                        child: Container(
     //                          padding: const EdgeInsets.all(8.0),
     //                          margin: const EdgeInsets.only(top: 5),
     //                          child: Row(
     //                            mainAxisAlignment:
     //                            MainAxisAlignment.spaceBetween,
     //                            children: [
     //                              Expanded(
     //                                child: AppTextWidgets.regularText(
     //                                  text:
     //                                  homeController.newData[index].name ??
     //                                      "",
     //                                  color: Theme.of(context).primaryColorDark,
     //                                  // maxLine: 2,
     //                                  size: 14,
     //                                ),
     //                              ),
     //                              const Icon(
     //                                Icons.search,
     //                                size: 18,
     //                              ),
     //                            ],
     //                          ),
     //                        ),
     //                      );
     //                    }),
     //              ),
     //              homeController.isLoadingMore.value
     //                  ? const Padding(
     //                padding: EdgeInsets.only(top: 15),
     //                child: CircularProgressIndicator(),
     //              )
     //                  : const SizedBox()
     //            ],
     //          ),
     //        ),
     //      ],
     //    ),
     //  )


      ///after
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:

        Builder(
          builder: (context) => InkWell(
                    onTap: ()=>Scaffold.of(context).openDrawer(),
                    child: Image.asset(AppImages.menuIcon)),
        ),



        title: Align(
            alignment: Alignment.center,
            child: Image.asset(AppImages.medixApp)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
                onTap:(){},child: Image.asset(AppImages.bell,)),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingSection(),
            SizedBox(height: 20),
            ConsultationCards(),
            SizedBox(height: 20),
            SearchDoctorField(),
            SizedBox(height: 20),
            DoctorsNearYouSection(),
            SizedBox(height: 20),
            SpecializationSection(),
            SizedBox(height: 20),
            PromotionalBanner(),
            SizedBox(height: 20),
            SpecialFeaturesSection(),
          ],
        ),
      ),



    );


  }
}


class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            const Text(
              'ELON MUSK',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4ECDC4),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF4ECDC4), size: 16),
                const SizedBox(width: 4),
                const Text(
                  'New Delhi',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ConsultationCards extends StatelessWidget {
  const ConsultationCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: ConsultationCard(
            title: 'Online Consultation',
            image: AppImages.intro2,
            //color: const Color(0xFFE8F8F7),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ConsultationCard(
            title: 'Clinic Consultation',
            image: AppImages.intro1,
            //color: const Color(0xFFFFF0F5),
          ),
        ),
      ],
    );
  }
}

class ConsultationCard extends StatelessWidget {
  final String title;
  final String image;
  final Color? color;

  const ConsultationCard({
    super.key,
    required this.title,
    required this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchDoctorField extends StatelessWidget {
  const SearchDoctorField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        //color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search Your Doctor',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Color(0xFF4ECDC4)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class DoctorsNearYouSection extends StatelessWidget {
  const DoctorsNearYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Doctors near you',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              DoctorCard(
                name: 'Dr. Akshay Rana',
                specialty: 'General Physician',
                experience: '5 Years Experience',
              ),
              DoctorCard(
                name: 'Dr. Umar Ahmad',
                specialty: 'Dental Surgeon',
                experience: '6 Years Experience',
              ),
              DoctorCard(
                name: 'Dr. Sanjay Singh',
                specialty: 'Orthopedic Surgeon',
                experience: '5 Years Experience',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String experience;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            specialty,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          // Text(
          //   experience,
          //   style: const TextStyle(
          //     fontSize: 10,
          //     color: Colors.grey,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}

class SpecializationSection extends StatelessWidget {
  const SpecializationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specialization',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 25,
          children: const [
            SpecializationCard(
              icon: Icons.medical_services,
              title: 'General Physician',
              bgColor: Color(0xFFE8F8F7),
            ),
            SpecializationCard(
              icon: Icons.healing,
              title: 'Dental Health',
              bgColor: Color(0xFFFFF8E1),
            ),
            SpecializationCard(
              icon: Icons.local_hospital,
              title: 'Homeopathy',
              bgColor: Color(0xFFE8F5E8),
            ),
            SpecializationCard(
              icon: Icons.child_care,
              title: 'Child Specialist',
              bgColor: Color(0xFFFFF0F5),
            ),
            SpecializationCard(
              icon: Icons.hearing,
              title: 'Ear, Nose & Throat',
              bgColor: Color(0xFFFFF0F5),
            ),
            SpecializationCard(
              icon: Icons.face,
              title: 'Skin & Hair',
              bgColor: Color(0xFFE8F8F7),
            ),
            SpecializationCard(
              icon: Icons.female,
              title: 'Women\'s Health',
              bgColor: Color(0xFFFFF0F5),
            ),
            SpecializationCard(
              icon: Icons.add,
              title: '& more',
              bgColor: Color(0xFFE8F8F7),
            ),
          ],
        ),
      ],
    );
  }
}

class SpecializationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color bgColor;

  const SpecializationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,           // <-- use min, not max

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            icon,
            size: 28,
            color: const Color(0xFF4ECDC4),
          ),
        ),
        const SizedBox(height: 6),
        Flexible(                               // <-- allow multi-line text
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,                       // optional safety limit
            overflow: TextOverflow.visible,    // keep 2 lines visible
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class PromotionalBanner extends StatelessWidget {
  const PromotionalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Get Flat 70% OFF on your first 3 Consultations',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SpecialFeaturesSection extends StatelessWidget {
  const SpecialFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Features',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260, // Adjust height based on your card content
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              SpecialFeatureCard(
                title: 'Second Opinion',
                subtitle1:
                'Experts review your diagnosis - ',
                subtitle2: 'for safer and smarter care',
                image: AppImages.sp1,
                bgColor: Color(0xFFE0F7FA),
              ),
              SpecialFeatureCard(
                title: 'Dietitian',
                subtitle1: 'Nutrition guidance for a ',
                subtitle2: 'Healthier you',
                image: AppImages.sp2,
                bgColor: Color(0xFFE8F5E9),
              ),
              SpecialFeatureCard(
                title: 'Mental Health',
                subtitle1: 'Consultation for ',
                subtitle2: 'Psychological Counseling',
                image: AppImages.sp3,
                bgColor: Color(0xFFFFF3E0),
              ),
              SpecialFeatureCard(
                title: 'Physiotherapist',
                subtitle1: 'Specialized Care for ',
                subtitle2: 'Pain Management',
                image: AppImages.sp4,
                bgColor: Color(0xFFF3E5F5),
              ),
              SpecialFeatureCard(
                title: 'Nursing Facility',
                subtitle1: 'Professional nursing care, ',
                subtitle2: 'at your home',
                image: AppImages.sp5,
                bgColor: Color(0xFFF3E5F5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;

  final String image;
  final Color bgColor;

  const SpecialFeatureCard({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // Card width
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.only(left:16,right:16,top:10),
      decoration: BoxDecoration(
        color: const Color(0xFF49BFAB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Medixcy",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  AppImages.medixcIcon, // optional small logo
                  height: 23,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: subtitle1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: subtitle2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              image,
              width:Get.width,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFE8F8F7),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Elon Musk',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Medixy Id: 2024012',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xFF4ECDC4), size: 16),
                        const SizedBox(width: 4),
                        const Text(
                          'Delhi',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerItem(
                  icon: Icons.calendar_today,
                  title: 'My Appointments',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.shopping_bag,
                  title: 'Orders',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.people,
                  title: 'My Doctors',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.medical_services,
                  title: 'Medical Records',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.payment,
                  title: 'Payment History',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.security,
                  title: 'Insurance Policy',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.article,
                  title: 'HealthLine Articles',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.location_city,
                  title: 'Our Centers',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.feedback,
                  title: 'Suggestion & Feedback',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.person_add,
                  title: 'Invite Friends',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.help,
                  title: 'Help Center',
                  onTap: () {},
                ),
                DrawerItem(
                  icon: Icons.local_hospital,
                  title: 'Are you a doctor ?',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Join us at',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Text(
                  'HealthLine',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4ECDC4),
                  ),
                ),
                const Text(
                  'Made in India',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}