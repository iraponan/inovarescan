import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/controllers/user_cronos.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/repositories/mssql/home.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> percQttSeparations = RxMap();
  RxList<Map<String, dynamic>> qttBySeparator = RxList();
  RxList<Map<String, dynamic>> qttPerHour = RxList();
  RxInt touchedIndex = RxInt(-1);
  RxBool isLoading = RxBool(false);

  String typeData = VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação');
  DateTime dateIni = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime dateEnd = DateTime.now();

  final companyController = Get.find<CompanyController>();
  final authController = Get.find<AuthController>();
  final userCronosController = Get.find<UserCronosController>();

  final HomeDataCronosRepository _homeDataCronosRepository = HomeDataCronosRepository();

  @override
  void onInit() async {
    super.onInit();
    await companyController.getCompanyFromUser(authController.user);
    authController.user.accessCompanies = await userCronosController.getUserAccessCompanies(user: authController.user.userCronos);
    refreshData();
  }

  Future<void> getPercQttSeparations() async {
    final result = await _homeDataCronosRepository.getPercQttSeparationsFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
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
    final result = await _homeDataCronosRepository.getQttBySeparatorFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
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
    final result = await _homeDataCronosRepository.getQttPerHourFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
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
