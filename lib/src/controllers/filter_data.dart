import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';

class FilterDataController extends GetxController {
  RxString typeData = RxString(VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação'));
  Rx<DateTime> dateIni = Rx(DateTime(DateTime.now().year, DateTime.now().month, 1));
  Rx<DateTime> dateEnd = Rx(DateTime.now());
}
