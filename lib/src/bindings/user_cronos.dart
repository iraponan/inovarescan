import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/user_cronos.dart';

class UserCronosBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserCronosController());
  }
}
