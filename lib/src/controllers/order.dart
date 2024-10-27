import 'package:get/get.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/models/order.dart';
import 'package:inovarescan/src/repositories/mssql/order.dart';

import '../helpers/utils/utils.dart';

class OrderController extends GetxController {
  RxList<Order> orders = RxList([]);
  RxBool isLoading = RxBool(false);

  late String typeData;
  late DateTime dateIni;
  late DateTime dateEnd;
  late int page;
  late int itemsPerPage;
  late bool isLastPage;

  final OrderRepository _orderRepository = OrderRepository();

  @override
  void onInit() async {
    super.onInit();
    typeData = VariablesUtils.dateOptions.firstWhere((element) => element == 'Operação');
    dateIni = DateTime(DateTime.now().year, DateTime.now().month, 1);
    dateEnd = DateTime.now();
    page = 0;
    itemsPerPage = 5;
    isLastPage = false;
    await getOrders();
  }

  Future<void> getOrders() async {
    await Future.delayed(Duration(seconds: 2));
    final result = await _orderRepository.getOrders(typeData: typeData, dateIni: dateIni, dateEnd: dateEnd, page: page, itemsPerPage: itemsPerPage);
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
}
