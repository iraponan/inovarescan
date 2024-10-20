import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/controllers/company.dart';
import 'package:inovarescan/src/repositories/mssql/home.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> ordersPeriod = RxMap();
  DateTime dateIni = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime dateEnd = DateTime.now();

  final companyController = Get.find<CompanyController>();
  final authController = Get.find<AuthController>();

  @override
  void onInit() async {
    super.onInit();
    await companyController.getCompanyFromUser(authController.user);
    getOrdersPeriod(dateIni: dateIni, dateEnd: dateEnd);
  }

  final HomeDataCronosRepository _homeDataCronosRepository = HomeDataCronosRepository();

  void getOrdersPeriod({DateTime? dateIni, DateTime? dateEnd}) async {
    ordersPeriod.value = await _homeDataCronosRepository.getDataFromCronos(dateIni: dateIni, dateEnd: dateEnd);
    update();
  }

  void refreshData() {
    getOrdersPeriod(dateIni: dateIni, dateEnd: dateEnd);
    update();
  }
}
