import 'package:flutter/material.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/pharmacy_order_screen.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

import 'laboratory_report_screen.dart';

class TabScreenOrderScreen extends StatefulWidget {
  @override
  _TabScreenOrderScreenState createState() => _TabScreenOrderScreenState();
}

class _TabScreenOrderScreenState extends State<TabScreenOrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController!.index == 1 && _tabController!.indexIsChanging) {
      print('Switched to PharmacyOrderScreen');
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: MyTabBar(),
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  UserPastAppointmentsController userPastAppointmentsController =
  UserPastAppointmentsController();
  TabController? tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(() {
      if (!tabController!.indexIsChanging) {
        setState(() {
          // Perform actions when tab changes
          if (tabController!.index == 1) {
            userPastAppointmentsController.fetchPharmacyOrder();
            userPastAppointmentsController.update();
          } else if (tabController!.index == 2) {
            // userPastAppointmentsController.fetchLaboratoryOrder();
            userPastAppointmentsController.update();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'my_orders'.tr,
        ),
        leading: Container(),
        elevation: 0,
      ),
      backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 08.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: AppColors.WHITE),
              padding: EdgeInsets.all(4),
              child: TabBar(
                controller: tabController,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.color1, AppColors.color2],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                isScrollable: true,
                labelColor: AppColors.WHITE,
                unselectedLabelColor: AppColors.grey,
                labelStyle: const TextStyle(
                  fontFamily: AppFontStyleTextStrings.medium,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: AppFontStyleTextStrings.medium,
                  fontSize: 14,
                ),
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Text(
                      'all_appointment1'.tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'pharmacy_order'.tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'order_report'.tr,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(


            child: TabBarView(

              controller: tabController,
              children: [
                UserPastAppointmentsScreen(),
                PharmacyOrderScreen(),
                LaboratoryReportScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
