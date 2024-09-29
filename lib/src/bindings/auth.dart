import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
