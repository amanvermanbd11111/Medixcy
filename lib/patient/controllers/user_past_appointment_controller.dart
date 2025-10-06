import 'dart:developer';

import 'package:videocalling_medical/common/utils/app_imports.dart';

import '../model/pharmacy_order_model.dart';

class UserPastAppointmentsController extends GetxController {

  RxList<AppointmentData> list = <AppointmentData>[].obs;
  String? userId ;

  RxBool isAppointmentExist = false.obs;

  RxBool isAppointmentExist1 = false.obs;
  RxBool isAppointmentExist2 = false.obs;

  RxBool isErrorInLoading = false.obs;

  RxBool isErrorInLoading1 = false.obs;
  RxBool isErrorInLoading2 = false.obs;

  RxBool isLoaded = false.obs;

  RxBool isLoaded1 = false.obs;
  RxBool isLoaded2 = false.obs;

  RxBool isLoadingMore = false.obs;

  String nextUrl = "";
  String? time1;
  DateTime? datetime1;
  RxList<String> ampm1 = <String>[].obs;

  UserAppointmentsClass? userAppointmentsClass;
  ScrollController scrollController = ScrollController();
  fetchUpcomingAppointments() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/userspastappointment?user_id=$userId"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        isAppointmentExist.value = true;
        userAppointmentsClass = UserAppointmentsClass.fromJson(jsonResponse);
        list.addAll(userAppointmentsClass!.data!.appointmentData!);
        nextUrl = userAppointmentsClass!.data!.nextPageUrl!;
        update();
      } else {
        isAppointmentExist.value = false;
        update();
      }
    }
    isLoaded.value = true;
    update();
  }

  PharmacyOrder pharmacyOrder = PharmacyOrder();
  RxList<orderdata> orderlist = <orderdata>[].obs;

  fetchPharmacyOrder() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_user_order_list?user_id=${userId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading1.value = true;
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        isAppointmentExist1.value = true;
        pharmacyOrder = PharmacyOrder.fromJson(jsonResponse);

        print(response.request!.url);
        orderlist.addAll(pharmacyOrder.data as Iterable<orderdata>);
        for (int i = 0; i < orderlist.length; i++) {
          String? createdAt = orderlist[i].createdAt;
          if (createdAt != null) {
            String time1 = "${createdAt.substring(0, 19)}";
            DateTime datetime1 = DateTime.parse(time1).toLocal();
            String ampm = datetime1.hour < 12 ? 'AM' : 'PM';
            ampm1.value.add(ampm);
          }
        }
        print(orderlist.length);


        // userAppointmentsClass = UserAppointmentsClass.fromJson(jsonResponse);
        // list.addAll(userAppointmentsClass!.data!.appointmentData!);
        // nextUrl = userAppointmentsClass!.data!.nextPageUrl!;
        update();
      } else {
        isAppointmentExist1.value = false;
        update();
      }
    }
    isLoaded1.value = true;
    update();
  }

  LaboratoryReport laboratoryReport = LaboratoryReport();
  RxList<reportdata> reportList = <reportdata>[].obs;

  fetchLaboratoryOrder() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_user_report_list?user_id=${userId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading2.value = true;
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        isAppointmentExist2.value = true;

        laboratoryReport = LaboratoryReport.fromJson(jsonResponse);

        print(response.request!.url);
        reportList.addAll(laboratoryReport.data as Iterable<reportdata>);
        for (int i = 0; i < reportList.length; i++) {
          String? createdAt = reportList[i].createdAt;
          if (createdAt != null) {
            String time1 = "${createdAt.substring(0, 19)}";
            DateTime datetime1 = DateTime.parse(time1).toLocal();
            String ampm = datetime1.hour < 12 ? 'AM' : 'PM';
            ampm1.value.add(ampm);
          }
        }
        print(reportList.length);


        update();
      } else {
        isAppointmentExist2.value = false;
        update();
      }
    }
    isLoaded2.value = true;
    update();
  }

  loadMore() async {
    if (nextUrl != "null") {
      final response = await get(Uri.parse("$nextUrl&user_id=$userId"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'].toString() == "1") {
          userAppointmentsClass = UserAppointmentsClass.fromJson(jsonResponse);
          list.addAll(userAppointmentsClass!.data!.appointmentData!);
          nextUrl = userAppointmentsClass!.data!.nextPageUrl!;
        }
      }
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    userId = StorageService.readData(key: LocalStorageKeys.userId) ?? "";
    fetchUpcomingAppointments();
    await fetchPharmacyOrder();
    await fetchLaboratoryOrder();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }
}
