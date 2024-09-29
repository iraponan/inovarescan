import 'package:get/get.dart';
import 'package:inovarescan/src/config/page_routes.dart';
import 'package:inovarescan/src/controllers/auth.dart';
import 'package:inovarescan/src/services/connection.dart';

class ConnectionController extends GetxController {
  Future<void> validateConnection() async {
    await Future.delayed(Duration(seconds: 3));
    bool statusConnection = await ConnectionCheck.checkConnection();
    if (statusConnection) {
      Get.find<AuthController>().getCurrentUser();
    } else {
      Get.offAllNamed(PageRoutes.connectionErrorRoute);
    }
  }
}
