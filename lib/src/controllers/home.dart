import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/connection.dart';
import 'package:inovarescan/src/controllers/filter_data.dart';
import 'package:inovarescan/src/controllers/user_cronos.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/repositories/mssql/home.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> percQttSeparations = RxMap();
  RxList<Map<String, dynamic>> qttBySeparator = RxList();
  RxList<Map<String, dynamic>> qttPerHour = RxList();
  RxInt touchedIndex = RxInt(-1);
  RxBool isLoading = RxBool(false);

  final filterDataController = Get.find<FilterDataController>();

  final companyController = Get.find<ConnectionController>();
  final authController = Get.find<AuthController>();
  final userCronosController = Get.find<UserCronosController>();

  final HomeDataCronosRepository _homeDataCronosRepository = HomeDataCronosRepository();

  @override
  void onInit() async {
    super.onInit();
    await companyController.getCompanyFromUser(authController.user);
    authController.user.accessCompanies = await userCronosController.getUserAccessCompanies(user: authController.user.userCronos);
    filterDataController.setCompaniesOptions(companies: authController.user.accessCompanies ?? []);
    refreshData();
  }

  Future<void> getPercQttSeparations() async {
    final result = await _homeDataCronosRepository.getPercQttSeparationsFromCronos(
      typeData: filterDataController.typeData.value,
      dateIni: filterDataController.dateIni.value,
      dateEnd: filterDataController.dateEnd.value,
      companies: filterDataController.selectedOptions,
    );
    result.when(
      success: (data) {
        percQttSeparations.value = data;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getQttBySeparator() async {
    final result = await _homeDataCronosRepository.getQttBySeparatorFromCronos(
      typeData: filterDataController.typeData.value,
      dateIni: filterDataController.dateIni.value,
      dateEnd: filterDataController.dateEnd.value,
      companies: filterDataController.selectedOptions,
    );
    result.when(
      success: (data) {
        qttBySeparator.value = data.map((i) => i as Map<String, dynamic>).toList();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getQttPerHour() async {
    final result = await _homeDataCronosRepository.getQttPerHourFromCronos(
      typeData: filterDataController.typeData.value,
      dateIni: filterDataController.dateIni.value,
      dateEnd: filterDataController.dateEnd.value,
      companies: filterDataController.selectedOptions,
    );
    result.when(
      success: (data) {
        qttPerHour.value = data.map((i) => i as Map<String, dynamic>).toList();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  void refreshData() async {
    isLoading.value = true;
    percQttSeparations.value = {};
    qttBySeparator.value = [];
    qttPerHour.value = [];
    await getPercQttSeparations();
    await getQttBySeparator();
    await getQttPerHour();
    await _homeDataCronosRepository.disconnectMssql();
    update();
    isLoading.value = false;
  }
}
