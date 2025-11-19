import 'package:videocalling_medical/patient/utils/patient_imports.dart';
import '../../common/utils/app_imports.dart';



class DAllNearbyController extends GetxController {
  ///2 for pharmacy, 1 for doctor
  int page = 2;

  RxBool isErrorInNearby = false.obs;
  RxBool isNearbyLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxString nextUrl = "".obs;
  RxBool isErrorInLoading = false.obs;
  RxString lat = "".obs;
  RxString lon = "".obs;

  TextEditingController textController = TextEditingController();
  RxBool isSearching = false.obs;
  RxBool isSearchDataLoaded = false.obs;
  RxString searchKeyword = "".obs;

  ScrollController scrollController = ScrollController();
  NearbyDoctorsClass? nearbyDoctorsClass;
  PharmacyData? pharmacyData;

  RxList<NearbyData> list = <NearbyData>[].obs;
  RxList<PData> list1 = <PData>[].obs;

  String? selected_city;

  var selected_city_name = "".obs;

  RxList<SDoctorData> newData = <SDoctorData>[].obs;
  SearchDoctorClass? searchDoctorClass;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    selected_city =
    "${StorageService.readData(key: LocalStorageKeys.sortCityId) ?? "0"}";
    selected_city_name.value =
    "${StorageService.readData(key: LocalStorageKeys.sortCityName) ?? "not"}";
    _getLocationStart();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page == 1) {
          loadMoreFunc();
        } else if (page == 2) {
          loadMorePharmacyData();
        } else if (page == 3) {
          loadMoreLaboratoryData();
        }
      }
    });
  }

  onChanged(String value) async {
    if (value.isEmpty) {
      newData.clear();
      isSearching.value = false;

    } else {
      if (!isSearching.value) {
        isSearching.value = true;

        await Future.delayed(const Duration(milliseconds: 850));
      }
      isSearchDataLoaded.value = false;
      final response = await get(
          Uri.parse("${Apis.ServerAddress}/api/searchdoctor?term=$value"))
          .timeout(const Duration(seconds: Apis.timeOut))
          .catchError((e) {
        isSearchDataLoaded.value = true;
      });
      if (response.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(response.body);
          searchDoctorClass = SearchDoctorClass.fromJson(jsonResponse);
          newData.clear();
          newData.addAll(searchDoctorClass!.data!.doctorData!);
          nextUrl.value = searchDoctorClass!.data!.nextPageUrl.toString();
          isSearchDataLoaded.value = true;
        } catch (e) {
          isSearchDataLoaded.value = true;
        }
      } else {
        isSearchDataLoaded.value = true;
      }
    }
  }
  callPharmacyApi({double? latitude, double? longitude, String? cityId}) async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/nearbydoctor?type=2&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      isErrorInNearby.value = true;
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    });
    print(response.statusCode);
    print(response.request!.url);

    if (response.statusCode == 200 ){
      if(jsonDecode(response.body)['status'] == 1) {
        final jsonResponse = jsonDecode(response.body);

        pharmacyData = PharmacyData.fromJson(jsonResponse);

        lat.value = latitude.toString();
        lon.value = longitude.toString();

        list1.addAll(pharmacyData!.data!.pharmacyData!);
        nextUrl.value = pharmacyData!.data!.nextPageUrl!;
        isNearbyLoading.value = false;
      } else {
        isNearbyLoading.value = false;
        isErrorInNearby.value = true;
        // customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
      }
    }else{
      isNearbyLoading.value = false;
      isErrorInLoading.value = true;
    }
  }
  callLaboratoryApi({double? latitude, double? longitude, String? cityId}) async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/nearbydoctor?type=3&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0}"))
        .timeout(const Duration(seconds: Apis.timeOut))
        .catchError((e) {
      print(e);
      isErrorInLoading.value = true;
      customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    });
    print(response.statusCode);
    print(response.request!.url);

    if (response.statusCode == 200 ){
      if(jsonDecode(response.body)['status'] == 1) {
        final jsonResponse = jsonDecode(response.body);

        pharmacyData = PharmacyData.fromJson(jsonResponse);

        lat.value = latitude.toString();
        lon.value = longitude.toString();

        list1.addAll(pharmacyData!.data!.pharmacyData!);
        nextUrl.value = pharmacyData!.data!.nextPageUrl!;
        isNearbyLoading.value = false;
      } else {
        isNearbyLoading.value = false;
        isErrorInNearby.value = true;
        // customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
      }
    }else{
      isNearbyLoading.value = false;
      isErrorInLoading.value = true;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  loadMoreFunc() async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      final response =
      await get(Uri.parse("${nextUrl.value}&type=1&lat=$lat&lon=$lon"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);

        nextUrl.value = nearbyDoctorsClass?.data?.nextPageUrl ?? "null";
        list.addAll(nearbyDoctorsClass!.data!.nearbyData!);
        isLoadingMore.value = false;
      }
    }
  }

  loadMorePharmacyData() async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      final response =
      await get(Uri.parse("${nextUrl.value}&type=2&lat=$lat&lon=$lon"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        pharmacyData = PharmacyData.fromJson(jsonResponse);
        nextUrl.value = pharmacyData!.data!.nextPageUrl!;
        list1.addAll(pharmacyData!.data!.pharmacyData!);
        isLoadingMore.value = false;
      }
    }
  }
  loadMoreLaboratoryData() async {
    if (nextUrl.value != "null") {
      isLoadingMore.value = true;
      final response =
      await get(Uri.parse("${nextUrl.value}&type=3&lat=$lat&lon=$lon"))
          .timeout(const Duration(seconds: Apis.timeOut));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        pharmacyData = PharmacyData.fromJson(jsonResponse);
        nextUrl.value = pharmacyData!.data!.nextPageUrl!;
        list1.addAll(pharmacyData!.data!.pharmacyData!);
        isLoadingMore.value = false;
      }
    }
  }

  callApi({double? latitude, double? longitude, String? cityId}) async {
    final response = await get(Uri.parse(
        "${Apis.ServerAddress}/api/nearbydoctor?type=1&lat=$latitude&lon=$longitude&city_id=${cityId ?? 0}"));

    print("response.request!.url");
    print(response.request!.url);

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200 ){if( jsonResponse['status'] == 1) {
      isNearbyLoading.value = false;

      nearbyDoctorsClass = NearbyDoctorsClass.fromJson(jsonResponse);
      list.addAll(nearbyDoctorsClass!.data!.nearbyData!);
      lat.value = latitude.toString();
      lon.value = longitude.toString();
      nextUrl.value = nearbyDoctorsClass!.data!.nextPageUrl!;
    } else {
      isNearbyLoading.value = false;
      isErrorInNearby.value = true;
      // customDialog(s1: 'error'.tr, s2: 'unable_to_load_data'.tr);
    }
    }else{
      isNearbyLoading.value = false;
      isErrorInLoading.value = true;
    }
  }

  void _getLocationStart() async {
    isErrorInNearby.value = false;
    isNearbyLoading.value = true;
    if (Platform.isIOS) {
      if (page == 1) {
        callApi(latitude: 0.0, longitude: 0.0, cityId: selected_city);
      } else if(page == 2) {
        callPharmacyApi(cityId: selected_city, latitude: 0.0, longitude: 0.0);
      } else if(page == 3){
        callLaboratoryApi(cityId: selected_city, latitude: 0.0, longitude: 0.0);
      }
    } else {
      if (page == 1) {
        print("profile123456 at doctor api");
        callApi(
            latitude: double.parse(latitude.toString()),
            longitude: double.parse(longitude.toString()),
            cityId: selected_city);
      } else if(page == 2){
        print("profile123456 at pharmacy api");
        callPharmacyApi(
            cityId: selected_city,
            latitude: double.parse(latitude.toString()),
            longitude: double.parse(longitude.toString()));
      } else if(page == 3){
        print("profile123456 at laboratory api");
        callLaboratoryApi(
            cityId: selected_city,
            latitude: double.parse(latitude.toString()),
            longitude: double.parse(longitude.toString()));
      }
    }
  }
}
