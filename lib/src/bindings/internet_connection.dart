import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/internet_connection.dart';

class InternetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectionController());
  }
}
