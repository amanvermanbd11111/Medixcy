import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

import '../../common/screens/ai_chat_screen.dart';


class PatientTabsScreen extends GetView<PatientTabController> {
  const PatientTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PatientTabController tabController = Get.put(PatientTabController());
    return Obx(() => Scaffold(
      body: tabController.getPage(tabController.index.value)
      ,
      floatingActionButton: SizedBox(
        width: 95,
        height: 95,
        child: FloatingActionButton(
          onPressed: () {

            Get.to(() => AiChatScreen());
          },
          backgroundColor: const Color(0xFF64B9A8),
          //  elevation: 8,
          shape: const CircleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.assistant, ),
              const SizedBox(height: 2),
              const Text(
                "Ask Asha",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      bottomNavigationBar:

          ///old bottom app bar
      // Obx(() => Container(
      //       decoration: BoxDecoration(
      //         color: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      //       ),
      //       child: ClipRRect(
      //         borderRadius: const BorderRadius.only(
      //             topRight: Radius.circular(15), topLeft: Radius.circular(15)),
      //         child: BottomNavigationBar(
      //           items: [
      //             BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 tabController.index.value == 0
      //                     ? AppImages.tab1Select
      //                     : AppImages.tab1Unselect,
      //                 height: 25,
      //                 width: 25,
      //               ),
      //               label: 'home'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 tabController.index.value == 1
      //                     ? AppImages.tab2Select
      //                     : AppImages.tab2Unselect,
      //                 height: 25,
      //                 width: 25,
      //                 fit: BoxFit.cover,
      //               ),
      //               label: 'appointment'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 tabController.index.value == 2
      //                     ? AppImages.tab3uSelect
      //                     : AppImages.tab3uUnselect,
      //                 height: 25,
      //                 width: 25,
      //                 fit: BoxFit.cover,
      //               ),
      //               label: 'doctor_login'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 tabController.index.value == 3
      //                     ? AppImages.tab4Select
      //                     : AppImages.tab4Unselect,
      //                 height: 25,
      //                 width: 25,
      //                 // fit: BoxFit.cover,
      //               ),
      //               label: 'recent_chats'.tr,
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 tabController.index.value == 4
      //                     ? AppImages.tab5Select
      //                     : AppImages.tab5Unselect,
      //                 height: 25,
      //                 width: 25,
      //                 fit: BoxFit.cover,
      //               ),
      //               label: 'more'.tr,
      //             ),
      //           ],
      //           selectedLabelStyle: const TextStyle(
      //             color: AppColors.BLACK,
      //             fontFamily: AppFontStyleTextStrings.regular,
      //             fontSize: 8,
      //           ),
      //           type: BottomNavigationBarType.fixed,
      //           unselectedLabelStyle: const TextStyle(
      //             fontFamily: AppFontStyleTextStrings.regular,
      //             color: AppColors.BLACK,
      //             fontSize: 7,
      //           ),
      //           unselectedItemColor: AppColors.LIGHT_GREY_TEXT,
      //           selectedItemColor: AppColors.BLACK,
      //           onTap: (i) {
      //             if (i == 0) {
      //               Get.lazyPut<UserHomeController>(
      //                 () => UserHomeController(),
      //               );
      //             } else if (i == 1) {
      //               Get.lazyPut<UserPastAppointmentsController>(
      //                 () => UserPastAppointmentsController(),
      //               );
      //             } else if (i == 2) {
      //               Get.lazyPut<DoctorLoginController>(
      //                 () => DoctorLoginController(),
      //               );
      //             } else if (i == 3) {
      //               Get.lazyPut<PatientChatListController>(
      //                 () => PatientChatListController(),
      //               );
      //             } else if (i == 4) {
      //               Get.lazyPut<PatientMoreScreenController>(
      //                 () => PatientMoreScreenController(),
      //               );
      //             }
      //             if (tabController.index.value == 0) {
      //               Get.delete<UserHomeController>();
      //             } else if (tabController.index.value == 3) {
      //               Get.delete<PatientChatListController>();
      //             } else if (tabController.index.value == 1) {
      //               Get.delete<UserPastAppointmentsController>();
      //             } else if (tabController.index.value == 2) {
      //               Get.delete<DoctorLoginController>();
      //             } else if (tabController.index.value == 4) {
      //               Get.delete<PatientMoreScreenController>();
      //             }
      //
      //             tabController.index.value = i;
      //           },
      //           currentIndex: tabController.index.value,
      //         ),
      //       ),
      //     )),


      ///new bottam app bar
      Container(
        decoration: const BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),


        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 12,
            color: Color(0xffF6F6F6),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(
                  controller: tabController,
                  icon: AppImages.tab1,
                  label: 'Home',
                  index: 0,
                ),
                _buildBottomNavItem(
                  controller: tabController,
                  icon: AppImages.tab2,
                  label: 'Medicines',
                  index: 1,
                ),
                const SizedBox(width: 70), // space for center FAB
                _buildBottomNavItem(
                  controller: tabController,
                  icon: AppImages.tab3,
                  label: 'Lab Tests',
                  index: 2,
                ),
                _buildBottomNavItem(
                  controller: tabController,
                  icon: AppImages.tab4,
                  label: 'Blood Bank',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),


    ));
  }

  Widget _buildBottomNavItem({
    required PatientTabController controller,
    required String icon,
    required String label,
    required int index,
  }) {
    return InkWell(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isActive = controller.index.value == index;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              height: 30,
              color: isActive ? const Color(0xFF4ECDC4) : Colors.black54,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF4ECDC4) : Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }),
    );
  }
}


