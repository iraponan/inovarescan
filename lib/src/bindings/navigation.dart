import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/navigation.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
  }
}
