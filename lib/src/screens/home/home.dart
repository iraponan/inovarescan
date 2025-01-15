import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/screens/common_widgets/filters_dialog.dart';
import 'package:inovarescan/src/screens/home/components/bar_graphic.dart';
import 'package:inovarescan/src/screens/home/components/graphic_legend.dart';
import 'package:inovarescan/src/screens/home/components/linear_graphic.dart';
import 'package:inovarescan/src/screens/home/components/pizza_graphic_separacao.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                homeController.refreshData();
              },
              icon: Icon(
                Icons.refresh_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => FiltersDialog(
                    isHome: true,
                  ),
                );
              },
              icon: Icon(
                Icons.tune_outlined,
              ),
            )
          ],
        ),
        body: LoadingOverlay(
          isLoading: homeController.isLoading.value,
          color: CustomColors.customSwathColor.withValues(alpha: 0.5),
          progressIndicator: Padding(
            padding: const EdgeInsets.all(160.0),
            child: LoadingIndicator(
              indicatorType: Indicator.ballBeat,
              colors: [
                CustomColors.customSwathColor,
                CustomColors.customContrastColor,
                CustomColors.customContrastColor2,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Separações Feitas No Período.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Obx(() {
                            return GraphicLegend(
                              color: CustomColors.customContrastColor,
                              text: 'Falta Separar',
                              isSquare: false,
                              size: homeController.touchedIndex.value == 0 ? 20 : 16,
                              textColor: homeController.touchedIndex.value == 0 ? CustomColors.customContrastColor : Colors.black,
                            );
                          }),
                          Obx(() {
                            return GraphicLegend(
                              color: CustomColors.customSwathColor,
                              text: 'Separados',
                              isSquare: false,
                              size: homeController.touchedIndex.value == 1 ? 20 : 16,
                              textColor: homeController.touchedIndex.value == 1 ? CustomColors.customSwathColor : Colors.black,
                            );
                          }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: AspectRatio(
                          aspectRatio: 2.0,
                          child: Row(
                            children: [
                              PizzaGraphicSeparacao(
                                valueNSeparado: homeController.percQttSeparations[QuerysPercQtdSeparacoesColumnsNames.percNSeparado],
                                valueSeparado: homeController.percQttSeparations[QuerysPercQtdSeparacoesColumnsNames.percSeparado],
                                isPerc: true,
                                subtitle: 'Percentual',
                              ),
                              PizzaGraphicSeparacao(
                                valueNSeparado: homeController.percQttSeparations[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoNSeparado],
                                valueSeparado: homeController.percQttSeparations[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoSeparado],
                                subtitle: 'Quantidade',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.5,
                  ),
                  Text(
                    'Qtd. De Separações Por Hora.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LinearGraphic(homeController: homeController),
                  Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.5,
                  ),
                  Text(
                    'Qtd. Separada Por Separador.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BarGraphic(
                    homeController: homeController,
                    keyData: QueryQtdPorSeparadorColumnsNames.separador,
                    data: QueryQtdPorSeparadorColumnsNames.qtdSeparada,
                  ),
                  Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1.5,
                  ),
                  Text(
                    'Ticket Médio Por Separador',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BarGraphic(
                    homeController: homeController,
                    keyData: QueryQtdPorSeparadorColumnsNames.separador,
                    data: QueryQtdPorSeparadorColumnsNames.ticketAverage,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
