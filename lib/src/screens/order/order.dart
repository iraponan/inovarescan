import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/controllers/order.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/screens/common_widgets/filters_dialog.dart';
import 'package:inovarescan/src/screens/order/components/order_custom_card.dart';
import 'package:inovarescan/src/screens/order/components/order_placeholder.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
        actions: [
          GetBuilder<OrderController>(builder: (orderController) {
            return IconButton(
              onPressed: () {
                orderController.refreshData();
              },
              icon: Icon(
                Icons.refresh_outlined,
              ),
            );
          }),
          GetBuilder<OrderController>(builder: (orderController) {
            return IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => FiltersDialog(
                    isOrder: true,
                  ),
                );
              },
              icon: Icon(
                Icons.tune_outlined,
              ),
            );
          }),
        ],
      ),
      body: Obx(
        () {
          final orderController = Get.find<OrderController>();
          return orderController.orders.isEmpty
              ? ListView(
                  children: List.generate(
                    orderController.itemsPerPage,
                    (index) => CardOrderPlaceholder(),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if ((index + 1) == orderController.orders.length && !orderController.isLastPage) {
                      orderController.loadMoreOrders();
                    }
                    if (!orderController.isLoading.value) {
                      return OrderCustomCard(
                        tipoMov: orderController.orders[index].typeMov,
                        numMov: orderController.orders[index].numMov,
                        statusSepMov: orderController.orders[index].statusSepMov,
                        dateType: VariablesUtils.dateOptions.firstWhere((d) => d == 'Operação'),
                        dtMov: orderController.orders[index].dateMov,
                        codClient: orderController.orders[index].codClient,
                        nameClient: orderController.orders[index].nameClient,
                        razClient: orderController.orders[index].razClient,
                        cpfCNPJClient: orderController.orders[index].cpfCNPJClient,
                        vendor: orderController.orders[index].vendor,
                      );
                    } else {
                      return CardOrderPlaceholder();
                    }
                  },
                  itemCount: orderController.orders.length,
                );
        },
      ),
    );
  }
}
