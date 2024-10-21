import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/repositories/mssql/home.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> percQtdSeparacoes = RxMap();
  RxList<Map<String, dynamic>> qtdPorSeparador = RxList();

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

  void getPercQtdSeparacoes({DateTime? dateIni, DateTime? dateEnd}) async {
    percQtdSeparacoes.value = await _homeDataCronosRepository.getPercQtdSeparacoesFromCronos(dateIni: dateIni, dateEnd: dateEnd);
    update();
  }

  void getQtdPorSeparador({DateTime? dateIni, DateTime? dateEnd}) async {
    List<dynamic> queryItems = await _homeDataCronosRepository.getQtdPorSeparadorFromCronos(dateIni: dateIni, dateEnd: dateEnd);
    List<Map<String, dynamic>> items = queryItems.map((i) => i as Map<String, dynamic>).toList();
    qtdPorSeparador.value = items;
  }

  void refreshData() {
    getPercQtdSeparacoes(dateIni: dateIni, dateEnd: dateEnd);
    getQtdPorSeparador(dateIni: dateIni, dateEnd: dateEnd);
    update();
  }
}
