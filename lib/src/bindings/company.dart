import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/company.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CompanyController());
  }
}
