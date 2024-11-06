import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/utils.dart';
import 'package:inovarescan/src/models/order_items.dart';
import 'package:inovarescan/src/repositories/mssql/order_items.dart';

class OrderItemsController extends GetxController {
  RxList<OrderItems> ordersItems = RxList([]);
  RxBool isLoading = RxBool(false);

  final orderItemsRepository = OrderItemsRepository();

  void getOrderItems({required int idMov}) async {
    isLoading.value = true;
    final result = await orderItemsRepository.getOrdersItems(idMov: idMov);
    result.when(
      success: (items) {
        for (var item in items) {
          ordersItems.add(OrderItems.fromJson(item));
        }
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
    await orderItemsRepository.disconnectMssql();
    isLoading.value = false;
  }
}
