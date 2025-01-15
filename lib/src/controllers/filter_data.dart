import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';

class FilterDataController extends GetxController {
  RxString typeData = RxString(VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação'));
  Rx<DateTime> dateIni = Rx(DateTime(DateTime.now().year, DateTime.now().month, 1));
  Rx<DateTime> dateEnd = Rx(DateTime.now());
  RxMap<String, bool> companyOptions = RxMap({});
  RxMap<List<String>, bool> statusMov = RxMap({
    ['Em Digitação', 'N']: true,
    ['Finalizado', 'F']: true,
    ['Em Separação', 'E']: true,
    ['Separado', 'S']: true,
    ['Separado c/ Divergência', 'D']: true,
  });

  void setCompaniesOptions({required List<Map<String, dynamic>> companies}) {
    for (var company in companies) {
      companyOptions[company[QueryUserAccessCompaniesColumnsNames.idCompany]] = true;
    }
  }
}
