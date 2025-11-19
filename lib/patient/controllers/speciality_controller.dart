import 'package:videocalling_medical/common/utils/app_imports.dart';

class SpecialityController extends GetxController {
  SpecialityClass? specialityClass;
  RxBool isLoading = true.obs;
  RxBool isErrorInLoading = false.obs;
  List<Speciality> list = [];

  TextEditingController searchController = TextEditingController();
  RxString searchKeyword = "".obs;
  RxList<Speciality> filteredList = <Speciality>[].obs;

  getSpeciality() async {
    isLoading.value = true;
    final response =
        await get(Uri.parse("${Apis.ServerAddress}/api/getspeciality"))
            .timeout(const Duration(seconds: Apis.timeOut))
            .catchError((e) {
      isErrorInLoading.value = true;
    });

    try {
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        specialityClass = SpecialityClass.fromJson(jsonResponse);
        list.addAll(specialityClass!.data!);
        filteredList.addAll(list);
        isLoading.value = false;
      }
    } catch (e) {
      isErrorInLoading.value = true;
    }
    Client().close();
  }

  void onSearchChanged(String value) {
    searchKeyword.value = value;
    if (value.isEmpty) {
      filteredList.value = list;
    } else {
      filteredList.value = list.where((speciality) {
        return speciality.name!.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (list.isEmpty) {
      getSpeciality();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
