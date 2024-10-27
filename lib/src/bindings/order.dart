import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/order.dart';

class OrderBidding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
