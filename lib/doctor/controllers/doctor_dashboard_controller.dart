import 'package:get_storage/get_storage.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:videocalling_medical/patient/model/pharmacy_order_model.dart';

import '../../main.dart';
import '../utils/doctor_imports.dart';

class DoctorDashboardController extends GetxController {

  DoctorPastAppointmentsClass? doctorAppointmentsClass;
  PharmacyOrderClass? pharmacyorderdetail;

  LaboratoryReportClass? laboratoryReportDetail;

  DoctorProfileWithRating? doctorProfileWithRating;

  RxString doctorId = "".obs;
  RxBool isAppointmentAvailable = false.obs;
  RxBool isOrderAvailable = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isErrorInLoading = false.obs;
  RxBool isErrorInProfileLoading = false.obs;
  RxBool isProfileLoaded = false.obs;
  RxBool isPharmacy = false.obs;
  RxString loginKey = doctorKey.obs;

  // final incomingCallManager = Get.put(IncomingManageController());

  Widget buildRatingStars(double avgRating) {
    int rating = avgRating.toInt() ?? 1;
    List<Widget> stars = List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 2),
        child: Image.asset(
          index < rating ? AppImages.starFill : AppImages.starNoFill,
          height: 15,
          width: 15,
        ),
      );
    });
    return Row(children: stars);
  }

  fetchDoctorAppointment() async {
    isAppointmentAvailable.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctoruappointment?doctor_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInLoading.value = true;
    });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'].toString() == "1") {
        doctorAppointmentsClass =
            DoctorPastAppointmentsClass.fromJson(jsonResponse);
        isLoaded.value = true;
        isAppointmentAvailable.value = true;
      } else {
        isLoaded.value = true;
        isAppointmentAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchDoctorDetails() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctordetail?type=1&doctor_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'].toString() == "1") {
          doctorProfileWithRating =
              DoctorProfileWithRating.fromJson(jsonResponse);

          print(
              "${StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy)}");

          if ("${StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy)}" ==
              false) {
            if (doctorProfileWithRating!.data!.isSubscription == "0") {
              Get.toNamed(Routes.chooseYourPlanScreen, arguments: {
                'doctorUrl': doctorProfileWithRating!.data!.image.toString()
              });
            }
          }
          isProfileLoaded.value = true;
        } else {
          isErrorInProfileLoading.value = true;
        }
      } catch (E) {
        isErrorInProfileLoading.value = true;
      }
    } else {
      isErrorInProfileLoading.value = true;
    }
    Client().close();
  }

  fetchPharmacyDetails() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctordetail?type=2&pharmacy_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));
    print(response.request!.url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'].toString() == "1") {
          doctorProfileWithRating =
              DoctorProfileWithRating.fromJson(jsonResponse);

          print(
              "${StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy)}");

          isProfileLoaded.value = true;
        } else {
          isErrorInProfileLoading.value = true;
        }
      } catch (E) {
        isErrorInProfileLoading.value = true;
      }
    } else {
      isErrorInProfileLoading.value = true;
    }
    Client().close();
  }

  fetchLaboratoryDetails() async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/doctordetail?type=3&laboratory_id=${doctorId.value}"))
        .timeout(const Duration(seconds: Apis.timeOut));

    print(response.request!.url);
    // log(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      try {
        if (jsonResponse['success'].toString() == "1") {
          doctorProfileWithRating =
              DoctorProfileWithRating.fromJson(jsonResponse);

          print(
              "${StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy)}");

          isProfileLoaded.value = true;
        } else {
          isErrorInProfileLoading.value = true;
        }
      } catch (E) {
        isErrorInProfileLoading.value = true;
      }
    } else {
      isErrorInProfileLoading.value = true;
    }
    Client().close();
  }

  ///if pass type then show only pending orders

  fetchPharmacyOrder() async {
    // isErrorInLoading
    isOrderAvailable.value = false;
    isLoaded.value = false;
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_pharmacy_order_list?pharmacy_id=${doctorId.value}&type=1"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      print(e);
      isErrorInLoading.value = true;
    });
    print(response.request!.url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'].toString() == "1") {

        pharmacyorderdetail = PharmacyOrderClass.fromJson(jsonResponse);
        isLoaded.value = true;
        isOrderAvailable.value = true;

      } else {

        isLoaded.value = true;
        isOrderAvailable.value = false;
      }
    } else {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  fetchLaboratoryOrder() async {

    isOrderAvailable.value = false;
    isLoaded.value = false;

    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/get_laboratory_report_list?laboratory_id=${doctorId.value}&type=1"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      print(e);

      isErrorInLoading.value = true;
    });

    print("response.request!.url");
    print(response.request!.url);
    if (response.statusCode == 200) {

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'].toString() == "1") {

        laboratoryReportDetail = LaboratoryReportClass.fromJson(jsonResponse);


        print("1234567890");
        print(laboratoryReportDetail!.data!.length);
        print(isErrorInLoading);

        isLoaded.value = true;
        isOrderAvailable.value = true;
      }

      else {
        isLoaded.value = true;
        isOrderAvailable.value = false;
      }

    }
    else {
      isErrorInLoading.value = true;
    }

    Client().close();


  }

  Future<bool> dialogPop() async {
    StorageService.removeData(key: LocalStorageKeys.callSessionCS);
    return true;
  }

  dialog() {
    return Get.defaultDialog(
      onWillPop: dialogPop,
      barrierDismissible: true,
      title: 'call_accept_dialog_title'.tr,
      content: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                'call_accept_dialog_subtitle'.tr,
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      fetchDoctorAppointment();
    });
    refreshController.refreshCompleted();
  }

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loginKey.value =
    StorageService.readData(key: LocalStorageKeys.isLoggedInAsPharmacy)?? false
        ? pharmacyKey
        : StorageService.readData(key: LocalStorageKeys.isLoggedInAsDoctor)?? false
        ? doctorKey
        : StorageService.readData(
        key: LocalStorageKeys.isLoggedInAsLaboratory)?? false
        ? labKey
        : doctorKey;


    print("loginKey.value");
    print(loginKey.value);

    doctorId.value =
        StorageService.readData(key: LocalStorageKeys.userId) ?? "";


    if(loginKey.value == pharmacyKey ) {
      fetchPharmacyOrder();
      fetchPharmacyDetails();

    }else if(loginKey.value == labKey){
      fetchLaboratoryDetails();
      fetchLaboratoryOrder();
    }
    else{
      fetchDoctorAppointment();
      fetchDoctorDetails();
    }


    // if (isPharmacy.value) {
    //   fetchPharmacyOrder();
    //   fetchPharmacyDetails();
    // } else {
    //   fetchDoctorAppointment();
    //   fetchDoctorDetails();
    // }
    if (StorageService.readData(key: LocalStorageKeys.callSessionCS) != null) {
      dialog();
    }
  }

}
