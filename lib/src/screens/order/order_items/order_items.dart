import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/order.dart';
import 'package:inovarescan/src/controllers/order_items.dart';
import 'package:inovarescan/src/models/order.dart';
import 'package:inovarescan/src/screens/order/order_items/components/update_status_dialog.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class OrderItems extends StatefulWidget {
  const OrderItems({super.key});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> with SingleTickerProviderStateMixin {
  final Order order = Get.arguments;
  final orderController = Get.find<OrderController>();
  final orderItemsController = Get.find<OrderItemsController>();

  @override
  void initState() {
    super.initState();
    orderItemsController.getOrderItems(idMov: order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${order.typeMov} - ${order.numMov}'),
            SizedBox(
              child: Hero(
                tag: order.id,
                child: Material(
                  color: Colors.transparent,
                  child: RiveAnimatedIcon(
                    riveIcon: getRiveIcon(order.statusSepOrder),
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    strokeWidth: 3,
                    loopAnimation: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (orderItemsController.isLoading.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(160.0),
              child: LoadingIndicator(
                indicatorType: Indicator.ballTrianglePathColoredFilled,
                colors: [
                  CustomColors.customSwathColor,
                  CustomColors.customContrastColor,
                  CustomColors.customContrastColor2,
                ],
              ),
            ),
          );
        }
        return Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: orderItemsController.ordersItems.map((item) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: item.image != null
                                  ? Image.memory(item.image!)
                                  : CachedNetworkImage(
                                      imageUrl: dotenv.env['IMAGE_EMPTY'] ?? '',
                                      placeholder: (context, url) => CircularProgressIndicator(
                                        color: CustomColors.customSwathColor,
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                    ),
                            ),
                            SizedBox(
                              height: 120,
                              child: VerticalDivider(),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Código: '),
                                      Expanded(
                                        child: Text(
                                          item.productCod,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Referência: '),
                                      Expanded(
                                        child: Text(
                                          item.productReference,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Nome: '),
                                      Expanded(
                                        child: Text(
                                          item.productName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Fabricante: '),
                                      Expanded(
                                        child: Text(
                                          item.productManufacturer,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Grupo: '),
                                      Expanded(
                                        child: Text(
                                          item.productGroup,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: item.productStorageLocation.isNotEmpty,
                                    child: Row(
                                      children: [
                                        Text('Local: '),
                                        Expanded(
                                          child: Text(
                                            item.productStorageLocation,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Unid. Padrão'),
                                  Text(
                                    item.productStandardUnit,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Unid. da Venda'),
                                  Text(
                                    item.salesUnit,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: item.conversionFactor != 1.0,
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Text('Fator'),
                                    Text(
                                      item.conversionFactor < 1.0
                                          ? '1.0 ${item.salesUnit} / ${1 / item.conversionFactor} ${item.productStandardUnit}'
                                          : '1.0 ${item.productStandardUnit} / ${item.conversionFactor} ${item.salesUnit}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Divider(
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Estoque'),
                                  Text(
                                    '${item.currentBalance}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Qtd. Solicitada'),
                                  Text(
                                    '${item.qttRequested}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Qtd. Faturada'),
                                  Text(
                                    '${item.qttInvoiced}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Qtd. Separada'),
                                  Text(
                                    '${item.qttSeparate}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: item.hasAGrid,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    //style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                                    child: Text(
                                      'Grade',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: item.hasASerialNumber,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    //style: ElevatedButton.styleFrom(backgroundColor: CustomColors.customContrastColor2),
                                    child: Text(
                                      'N° de Serie',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: item.hasABatchNumber,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    //style: ElevatedButton.styleFrom(backgroundColor: CustomColors.customContrastColor2),
                                    child: Text(
                                      'Lote',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Visibility(
              visible: order.statusSepOrder == 'F',
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {
                      final bool? result = await showDialog(
                        context: context,
                        builder: (context) => UpdateStatusDialog(text: 'Colocar Movimento em Separação?'),
                      );
                      if (result ?? false) {
                        setState(() {
                          order.statusSepOrder = 'E';
                          orderController.updateStatusSepOrder(order: order);
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.barcode_reader,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Colocar em Separação',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: order.statusSepOrder == 'E',
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final bool? result = await showDialog(
                            context: context,
                            builder: (context) => UpdateStatusDialog(text: 'Cancelar Separação?'),
                          );
                          if (result ?? false) {
                            setState(() {
                              order.statusSepOrder = 'F';
                              orderController.updateStatusSepOrder(order: order);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Cancelar Separação',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final bool? result = await showDialog(
                            context: context,
                            builder: (context) => UpdateStatusDialog(text: 'Separar com divergência?'),
                          );
                          if (result ?? false) {
                            setState(() {
                              order.statusSepOrder = 'D';
                              orderController.updateStatusSepOrder(order: order);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade900,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Separar C/ Diverg.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final bool? result = await showDialog(
                            context: context,
                            builder: (context) => UpdateStatusDialog(text: 'Finalizar Separação?'),
                          );
                          if (result ?? false) {
                            setState(() {
                              order.statusSepOrder = 'S';
                              orderController.updateStatusSepOrder(order: order);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.customContrastColor2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Separar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: order.statusSepOrder == 'D' || order.statusSepOrder == 'S',
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        order.statusSepOrder = 'F';
                        orderController.updateStatusSepOrder(order: order);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Desfazer Separação',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  RiveIcon getRiveIcon(String status) {
    switch (status) {
      case 'S':
        return RiveIcon.check;
      case 'D':
        return RiveIcon.warning;
      case 'F':
        return RiveIcon.bin;
      case 'E':
        return RiveIcon.timer2;
      default:
        return RiveIcon.edit;
    }
  }
}
