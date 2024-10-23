import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/repositories/mssql/home.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> percQtdSeparacoes = RxMap();
  RxList<Map<String, dynamic>> qtdPorSeparador = RxList();
  RxList<Map<String, dynamic>> qtdPorHora = RxList();
  RxInt touchedIndex = RxInt(-1);
  RxBool isLoading = RxBool(false);

  String typeData = VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação');
  DateTime dateIni = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime dateEnd = DateTime.now();

  final companyController = Get.find<CompanyController>();
  final authController = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();
    await companyController.getCompanyFromUser(authController.user);
    refreshData();
  }

  final HomeDataCronosRepository _homeDataCronosRepository = HomeDataCronosRepository();

  Future<void> getPercQtdSeparacoes({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    final result = await _homeDataCronosRepository.getPercQtdSeparacoesFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    result.when(
      success: (data) {
        percQtdSeparacoes.value = data;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getQtdPorSeparador({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    final result = await _homeDataCronosRepository.getQtdPorSeparadorFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    result.when(
      success: (data) {
        qtdPorSeparador.value = data.map((i) => i as Map<String, dynamic>).toList();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getQtdPorHora({required String typeData, DateTime? dateIni, DateTime? dateEnd}) async {
    final result = await _homeDataCronosRepository.getQtdPorHoraFromCronos(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    result.when(
      success: (data) {
        qtdPorHora.value = data.map((i) => i as Map<String, dynamic>).toList();
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  void refreshData() async {
    isLoading.value = true;
    await getPercQtdSeparacoes(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    await getQtdPorSeparador(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    await getQtdPorHora(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd);
    _homeDataCronosRepository.disconnectMssql();
    isLoading.value = false;
  }
}
