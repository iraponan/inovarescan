import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/order_items.dart';
import 'package:inovarescan/src/models/order.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class OrderItems extends StatefulWidget {
  const OrderItems({super.key});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> with SingleTickerProviderStateMixin {
  final Order order = Get.arguments;
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
                    riveIcon: getRiveIcon(order.statusSepMov),
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    strokeWidth: 3,
                    loopAnimation: true,
                  ),
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        //log(orderItemsController.ordersItems.first.image!.toString());
        if (orderItemsController.ordersItems.isEmpty) {
          return Center(child: Text('Nenhum item encontrado.'));
        }
        return Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: orderItemsController.ordersItems.map((i) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: i.image != null
                                  ? Image.memory(i.image!)
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
                                          i.productCod,
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
                                          i.productReference,
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
                                          i.productName,
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
                                          i.productManufacturer,
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
                                          i.productGroup,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: i.productStorageLocation.isNotEmpty,
                                    child: Row(
                                      children: [
                                        Text('Local: '),
                                        Expanded(
                                          child: Text(
                                            i.productStorageLocation,
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
                                    i.productStandardUnit,
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
                                    i.salesUnit,
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
                              visible: i.conversionFactor != 1.0,
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Text('Fator'),
                                    Text(
                                      i.conversionFactor < 1.0
                                          ? '1.0 ${i.salesUnit} / ${1 / i.conversionFactor} ${i.productStandardUnit}'
                                          : '1.0 ${i.productStandardUnit} / ${i.conversionFactor} ${i.salesUnit}',
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
                                    '${i.currentBalance}',
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
                                    '${i.qttRequested}',
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
                                    '${i.qttInvoiced}',
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
                                    '${i.qttSeparate}',
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
                              visible: i.hasAGrid,
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
                              visible: i.hasASerialNumber,
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
                              visible: i.hasABatchNumber,
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
              visible: false, //order.statusSepMov == 'F',
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.barcode_reader),
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
              visible: false, //order.statusSepMov == 'F',
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade900),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.barcode_reader),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: CustomColors.customContrastColor2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle),
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
