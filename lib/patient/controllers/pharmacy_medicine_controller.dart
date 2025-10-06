import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/doctor/utils/doctor_imports.dart';

class PharmacyMedicineController extends GetxController {
  String id = Get.arguments['id'];
  RxString page = Get.arguments['page'].toString().obs;
  RxBool isLoggedIn = false.obs;
  RxInt itemcount = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    page.value = Get.arguments['page'].toString();
    if (page.value.toString() == "1") {
      callMostUsedMedicineApi();
    } else {
      callMostUsedReportApi();
    }
    getCartLength();

  }

  ScrollController allMedicineScrollController = ScrollController();
  ScrollController searchMedicineScrollController = ScrollController();

  TextEditingController searchMedicineController = TextEditingController();
  RxBool isSearchMedicineEmpty = false.obs;
  RxBool isMostUsedMedicineLoaded = false.obs;
  RxBool isLoadingSearchMedicine = false.obs;
  RxBool isSearch = false.obs;
  RxBool isLoading = false.obs;
  TextEditingController textController = TextEditingController();

  RxBool loadMore = false.obs;

  RxInt cnt = 0.obs;
  RxInt cartLength = 0.obs;

  RxString nextUrl = "".obs;
  RxString nextUrlSearch = "".obs;

  PharmacyMedicineData searchAddMedicineModel = PharmacyMedicineData();

  RxList<PMAData> ll = <PMAData>[].obs;
  RxList<PMAData> mostUsedMedicineList = <PMAData>[].obs;
  RxList<int> processedIndices = <int>[].obs;
  RxList<bool> mostUsedMedicineCheak = <bool>[].obs;
  RxList<bool> cheak = <bool>[].obs;
  String homeCharge = "0";
  String labCharge = "0";


  callMostUsedMedicineApi() async {
    isMostUsedMedicineLoaded.value = false;
    mostUsedMedicineList.clear();
    mostUsedMedicineCheak.clear();
    ll.clear();
    var response = await post(
      Uri.parse("${Apis.ServerAddress}/api/pharmacy_medicines"),
      body: {
        'pharmacy_id': id,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));

    if (response.statusCode == 200) {
      print(response.request!.url);
      log(response.body);

      searchAddMedicineModel =
          PharmacyMedicineData.fromJson(jsonDecode(response.body));

      mostUsedMedicineList.addAll(searchAddMedicineModel.data!);
      if (isSearch.value) {
        ll.addAll(searchAddMedicineModel.data!);
      }
      StorageService.writeStringData(
        key: LocalStorageKeys.tax,
        value: searchAddMedicineModel.pharmacyTax.toString(),
      );
      StorageService.writeStringData(
        key: LocalStorageKeys.deliverycharges,
        value: searchAddMedicineModel.pharmacyDeliveryCharge.toString(),
      );
      mostUsedMedicineCheak
          .addAll(List.filled(mostUsedMedicineList.length, false));
      // nextUrl.value = searchAddMedicineModel.data?.nextPageUrl ?? "null";
      isMostUsedMedicineLoaded.value = true;
      update();
    } else {
      isMostUsedMedicineLoaded.value = true;
    }
    cnt.value = 0;
    Client().close();
  }

  callMostUsedReportApi() async {
    isMostUsedMedicineLoaded.value = false;
    mostUsedMedicineList.clear();
    mostUsedMedicineCheak.clear();
    ll.clear();
    var response = await post(
      Uri.parse("${Apis.ServerAddress}/api/laboratory_report"),
      body: {
        'laboratory_id': id,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));

    if (response.statusCode == 200) {
      print(response.request!.url);
      log(response.body);

      final jsonResponse = jsonDecode(response.body);

      searchAddMedicineModel =
          PharmacyMedicineData.fromJson(jsonResponse);

      mostUsedMedicineList.addAll(searchAddMedicineModel.data!);
      if (isSearch.value) {
        ll.addAll(searchAddMedicineModel.data!);
      }
      StorageService.writeStringData(
        key: LocalStorageKeys.tax,
        value: searchAddMedicineModel.pharmacyTax.toString(),
      );
      StorageService.writeStringData(
        key: LocalStorageKeys.deliverycharges,
        value: searchAddMedicineModel.pharmacyDeliveryCharge.toString(),
      );
      StorageService.writeStringData(
        key: LocalStorageKeys.homeVisitCharge,
        value: jsonResponse["home_visit"].toString(),
      );
      homeCharge = jsonResponse["home_visit"].toString();
      StorageService.writeStringData(
        key: LocalStorageKeys.labVisitCharge,
        value:jsonResponse["lab_visit"].toString(),
      );
      labCharge = jsonResponse["lab_visit"].toString();


      mostUsedMedicineCheak
          .addAll(List.filled(mostUsedMedicineList.length, false));
      isMostUsedMedicineLoaded.value = true;
      update();
    } else {
      isMostUsedMedicineLoaded.value = true;
    }
    cnt.value = 0;
    Client().close();
  }

  searchMedicineApi({required String medicineName}) async {
    isSearch.value = true;
    isLoadingSearchMedicine.value = false;
    ll.clear();

    var response = await post(
      Uri.parse("${Apis.ServerAddress}/api/pharmacy_medicines"),
      body: {
        'pharmacy_id': id,
        'keyword': medicineName,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));

    if (response.statusCode == 200) {
      // ${StorageService.readData(key: LocalStorageKeys.tax)}

      print(response.request!.url);
      log(response.body);
      searchAddMedicineModel =
          PharmacyMedicineData.fromJson(jsonDecode(response.body));

      // mostUsedMedicineList.addAll(searchAddMedicineModel.data!.pharmacyData!);
      StorageService.writeStringData(
        key: LocalStorageKeys.tax,
        value: searchAddMedicineModel.pharmacyTax.toString(),
      );

      StorageService.writeStringData(
        key: LocalStorageKeys.deliverycharges,
        value: searchAddMedicineModel.pharmacyDeliveryCharge.toString(),
      );

      ll.addAll(searchAddMedicineModel.data!);
      cheak.addAll(List.filled(ll.length, false));
      // nextUrlSearch.value = searchAddMedicineModel.data?.nextPageUrl ?? "null";
      isLoadingSearchMedicine.value = true;
    } else {
      isLoadingSearchMedicine.value = true;
      ll.clear();
      searchMedicineController.clear();
    }
    cnt.value = 0;
    Client().close();
  }

  searchReportApi({required String medicineName}) async {
    isSearch.value = true;
    isLoadingSearchMedicine.value = false;
    ll.clear();

    var response = await post(
      Uri.parse("${Apis.ServerAddress}/api/laboratory_report"),
      body: {
        'laboratory_id': id,
        'keyword': medicineName,
      },
    ).timeout(const Duration(seconds: Apis.timeOut));

    if (response.statusCode == 200) {
      // ${StorageService.readData(key: LocalStorageKeys.tax)}

      print(response.request!.url);
      log(response.body);

      searchAddMedicineModel =
          PharmacyMedicineData.fromJson(jsonDecode(response.body));

      StorageService.writeStringData(
        key: LocalStorageKeys.tax,
        value: (searchAddMedicineModel.pharmacyTax ?? "0").toString(),
      );
      StorageService.writeStringData(
        key: LocalStorageKeys.deliverycharges,
        value:
        (searchAddMedicineModel.pharmacyDeliveryCharge ?? "0").toString(),
      );

      ll.addAll(searchAddMedicineModel.data!);
      cheak.addAll(List.filled(ll.length, false));
      isLoadingSearchMedicine.value = true;
    }
    else {
      isLoadingSearchMedicine.value = true;
      ll.clear();
      searchMedicineController.clear();
    }
    cnt.value = 0;
    Client().close();
  }

  searchLoadMoreMedicineApi() async {
    if (nextUrlSearch.value != "null" && nextUrlSearch.value.isNotEmpty) {
      loadMore.value = true;
      var response = await post(
        Uri.parse(nextUrlSearch.value),
        body: {
          'pharmacy_id': id,
          'keyword': searchMedicineController.text,
        },
      ).timeout(const Duration(seconds: Apis.timeOut));

      if (response.statusCode == 200) {
        searchAddMedicineModel =
            PharmacyMedicineData.fromJson(jsonDecode(response.body));
        if (searchAddMedicineModel.data?.isNotEmpty ?? false) {
          for (int i = 0;
          i < searchAddMedicineModel.data!.length;
          i++) {
            cheak.add(false);
            ll.add(searchAddMedicineModel.data![i]);
          }
        }
        // nextUrlSearch.value =
        //     searchAddMedicineModel.data?.nextPageUrl ?? "null";
        loadMore.value = false;
        searchMedicineScrollController.animateTo(
          searchMedicineScrollController.position.pixels + 50,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } else {
        loadMore.value = false;

        ll.clear();
      }
      cnt.value = 0;
      Client().close();
    }
  }

  callLoadMoreMostUsedMedicineApi() async {
    if (nextUrl.value != "null" && nextUrl.value.isNotEmpty) {
      loadMore.value = true;
      var response = await post(
        Uri.parse(nextUrl.value),
        body: {
          'pharmacy_id': id,
        },
      ).timeout(const Duration(seconds: Apis.timeOut));

      if (response.statusCode == 200) {
        searchAddMedicineModel =
            PharmacyMedicineData.fromJson(jsonDecode(response.body));
        print("After :: ${mostUsedMedicineList.length}");
        print("After :: ${mostUsedMedicineCheak.length}");
        if (searchAddMedicineModel.data?.isNotEmpty ?? false) {
          print("Here");
          for (int i = 0;
          i < searchAddMedicineModel.data!.length;
          i++) {
            mostUsedMedicineCheak.add(false);
            mostUsedMedicineList
                .add(searchAddMedicineModel.data![i]);
          }
        }
        // nextUrl.value = searchAddMedicineModel.data?.nextPageUrl ?? "null";
        loadMore.value = false;
        allMedicineScrollController.animateTo(
          allMedicineScrollController.position.pixels + 50,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } else {
        loadMore.value = false;
      }
      Client().close();
    }
  }


  getCartLength() async {
    List<CartMedicine> cart = await Get.find<DBHelperCart>().getCartList();
    processedIndices.clear();
    for (int i = 0; i < cart.length; i++) {
      processedIndices.add(int.parse(cart[i].mId.toString()));
    }
    print(processedIndices);
    cartLength.value = cart.length;
  }

  showToastMessage({required String msg}) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
      showCloseIcon: true,
      closeIconColor: AppColors.WHITE,
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
