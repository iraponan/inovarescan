import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/filter_data.dart';

class FilterDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterDataController());
  }
}
