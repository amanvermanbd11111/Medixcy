import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:http/http.dart' as http;
import 'package:videocalling_medical/main.dart';
import 'package:videocalling_medical/patient/controllers/user_past_appointment_controller.dart';
import '../../common/model/order_detail_model.dart';
import '../model/pharmacy_order_model.dart';

class UserAppointmentDetailsController extends GetxController {
  String id = Get.arguments['id'] ?? '0';
  RxString isPharmacy = doctorKey.obs;
  RxBool isprescription = false.obs;

  DoctorAppointmentDetailsClass? doctorAppointmentDetailsClass;
  Future? getAppointmentDetails;
  RxBool isErrorInLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxString doctorSpeciality = "".obs;
  RxString doctorId = "".obs;
  RxString userId = "".obs;
  Timer? countdownTimer;
  RxBool isSecondNagetive = false.obs;

  fetchAppointmentDetails() async {
    final response = await http
        .get(Uri.parse(
        "${Apis.ServerAddress}/api/appointmentdetail?id=${id}&type=1"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["success"].toString() == "1") {
        doctorAppointmentDetailsClass =
            DoctorAppointmentDetailsClass.fromJson(jsonResponse);
        if (jsonResponse['doctor']['departmentls'] != null) {
          doctorSpeciality.value =
              jsonResponse['doctor']['departmentls']['name'].toString();
        }
        doctorId.value = jsonResponse['data']['doctor_id'].toString();
        userId.value = jsonResponse['data']['user_id'].toString();
      }
    }
  }

  orderDetailClass dataList = orderDetailClass();

  reportDetailClass reportDataList = reportDetailClass();

  RxInt apStatus = 0.obs;

  RxInt apOrderStatus = 0.obs;

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  fetchOrderDetails() async {
    final response = await get(
        Uri.parse("${Apis.ServerAddress}/api/view_order?order_id=${id}"))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    print(response.request!.url);
    // log(response.body);
    // log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"].toString() == "1") {
        dataList = orderDetailClass.fromJson(jsonResponse);

        apOrderStatus.value = dataList.data?.status ?? 0;

        dataList.data!.orderType == 1
            ? isprescription.value = true
            : isprescription.value = false;
        userId.value = jsonResponse['data']['user_id'].toString();
        isLoaded.value = true;
      } else {
        isErrorInLoading.value = true;
        isLoaded.value = true;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchReportDetails() async {
    final response = await get(
        Uri.parse("${Apis.ServerAddress}/api/view_report?order_id=${id}"))
        .catchError((e) {
      isErrorInLoading.value = true;
    });

    print(response.request!.url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse["status"].toString() == "1") {
        reportDataList = reportDetailClass.fromJson(jsonResponse);

        apOrderStatus.value = reportDataList.data?.status ?? 0;


        userId.value = jsonResponse['data']['user_id'].toString();
        isLoaded.value = true;
      } else {
        isErrorInLoading.value = true;
        isLoaded.value = true;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  PharmacyOrder pharmacyOrder = PharmacyOrder();

  Future<bool> downloadAndSaveImage(String url) async {
    http.Client client = http.Client();
    var req = await client
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: Apis.timeOut));
    if (req.statusCode >= 400) {
      Get.back();
      customDialog(
        onPressed: () {
          Get.back();
        },
        s1: 'error'.tr,
        s2: '${req.reasonPhrase}'.tr,
      );
      return false;
    }
    var bytes = req.bodyBytes;
    try {
      String dir = '/storage/emulated/0/Dcim/${url.split("/").last}';
      File file = File(dir);
      await file.writeAsBytes(bytes);
      return true;
    } catch (e) {
      Get.back();
      customDialog(
        onPressed: () {
          Get.back();
        },
        s1: 'error'.tr,
        s2: e.toString(),
      );
      return false;
    }
  }

  changeOrderStatus(status) async {
    customDialog1(
        s1: 'reporting_dialog1'.tr, s2: 'please_wait_while_processing'.tr);
    final response = await post(Uri.parse(
        "${Apis.ServerAddress}/api/change_pharmacyorder_status?order_id=${id}&status=$status"));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {

        UserPastAppointmentsController userPastAppointmentsController = UserPastAppointmentsController();
        Get.back();
        Get.back();
        userPastAppointmentsController.fetchPharmacyOrder();
        userPastAppointmentsController.update();
        fetchAppointmentDetails();
      } else if (jsonResponse['success'].toString() == "0") {
        Get.back();
        Get.back();
        messageDialog('error'.tr, jsonResponse['msg']);
      }
    }
    Client().close();
  }

  Future<void> changeReportStatus(status) async {
    customDialog1(
        s1: 'reporting_dialog1'.tr, s2: 'please_wait_while_processing'.tr);
    final response = await post(Uri.parse(
        "${Apis.ServerAddress}/api/change_laboratoryreport_status?order_id=${id}&status=$status"));

    print(response.request!.url);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {
        Get.back();
      } else if (jsonResponse['success'].toString() == "0") {
        Get.back();
        messageDialog('error'.tr, jsonResponse['msg']);
      }
    }
    Client().close();
  }


  messageDialog(String s1, String s2) {
    customDialog(
      s1: s1,
      s2: s2,
      onPressed: () {
        if (s1 == 'error'.tr) {
          Get.back();
        } else {
          fetchAppointmentDetails();
        }
      },
    );
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit

    super.onInit();

    isPharmacy.value = Get.arguments["bool"] ?? doctorKey;

    print(isPharmacy.value);

    if (isPharmacy.value == doctorKey) {
      getAppointmentDetails = fetchAppointmentDetails();
    } else if (isPharmacy.value == pharmacyKey) {
      fetchOrderDetails();
    } else if (isPharmacy.value == labKey) {
      fetchReportDetails();
    }
  }
}
