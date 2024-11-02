import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';

class FilterDataController extends GetxController {
  RxString typeData = RxString(VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação'));
  Rx<DateTime> dateIni = Rx(DateTime(DateTime.now().year, DateTime.now().month, 1));
  Rx<DateTime> dateEnd = Rx(DateTime.now());
  RxMap<String, bool> selectedOptions = RxMap({});

  void setCompaniesOptions({required List<Map<String, dynamic>> companies}) {
    for (var company in companies) {
      selectedOptions[company[QueryUserAccessCompaniesColumnsNames.idCompany]] = true;
    }
  }
}
