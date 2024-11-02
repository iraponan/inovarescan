import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/filter_data.dart';
import 'package:inovarescan/src/models/order.dart';
import 'package:inovarescan/src/repositories/mssql/order.dart';

import '../helpers/utils/utils.dart';

class OrderController extends GetxController {
  RxList<Order> orders = RxList([]);
  RxBool isLoading = RxBool(false);

  final filterDataController = Get.find<FilterDataController>();

  final int itemsPerPage = 5;

  int page = 0;
  bool isLastPage = false;

  final OrderRepository _orderRepository = OrderRepository();

  @override
  void onInit() async {
    super.onInit();
    await getOrders();
  }

  Future<void> getOrders() async {
    await Future.delayed(Duration(seconds: 2));
    final result = await _orderRepository.getOrders(
      typeData: filterDataController.typeData.value,
      dateIni: filterDataController.dateIni.value,
      dateEnd: filterDataController.dateEnd.value,
      page: page,
      itemsPerPage: itemsPerPage,
      companies: filterDataController.selectedOptions,
    );
    result.when(
      success: (data) {
        for (var order in data) {
          orders.add(Order.fromJson(order));
        }
        isLastPage = data.isEmpty || data.length < itemsPerPage;
      },
      error: (message) {
        Utils.showToast(message: message, isError: true);
      },
    );
  }

  void loadMoreOrders() async {
    page++;
    isLoading.value = true;
    await getOrders();
    isLoading.value = false;
  }

  void refreshData() async {
    orders.value = [];
    isLoading.value = false;
    isLastPage = false;
    page = 0;
    await getOrders();
  }
}
