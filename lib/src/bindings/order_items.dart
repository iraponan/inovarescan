import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/order_items.dart';

class OrderItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderItemsController());
  }
}
