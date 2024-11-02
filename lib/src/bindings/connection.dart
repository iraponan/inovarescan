import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/connection.dart';

class ConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectionController());
  }
}
