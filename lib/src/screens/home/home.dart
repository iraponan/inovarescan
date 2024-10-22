import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/screens/home/components/bar_graphic.dart';
import 'package:inovarescan/src/screens/home/components/dates_dialog.dart';
import 'package:inovarescan/src/screens/home/components/indicator.dart';
import 'package:inovarescan/src/screens/home/components/pizza_graphic_separacao.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('Home'),
            ],
          ),
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
                  builder: (context) => DatesDialog(homeController: homeController),
                );
              },
              icon: Icon(
                Icons.tune,
              ),
            )
          ],
        ),
        body: Center(
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
                        Indicator(
                          color: CustomColors.customContrastColor,
                          text: 'Falta Separar',
                          isSquare: false,
                          size: touchedIndex == 0 ? 20 : 16,
                          textColor: touchedIndex == 0 ? CustomColors.customContrastColor : Colors.black,
                        ),
                        Indicator(
                          color: CustomColors.customSwathColor,
                          text: 'Separados',
                          isSquare: false,
                          size: touchedIndex == 1 ? 20 : 16,
                          textColor: touchedIndex == 1 ? CustomColors.customSwathColor : Colors.black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: Row(
                          children: [
                            PizzaGraphicSeparacao(
                              valueNSeparado: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percNSeparado],
                              valueSeparado: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percSeparado],
                              isPerc: true,
                              subtitle: 'Percentual',
                            ),
                            PizzaGraphicSeparacao(
                              valueNSeparado: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoNSeparado],
                              valueSeparado: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoSeparado],
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
                  'Qtd. Separada Por Separador.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BarGraphic(homeController: homeController),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5,
                ),
                Text(
                  'Qtd. de separações por hora.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 2.0,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(8, 0),
                            FlSpot(9, 1),
                            FlSpot(10, 3),
                            FlSpot(11, 4),
                            FlSpot(12, 2),
                            FlSpot(13, 0),
                            FlSpot(14, 2),
                            FlSpot(15, 2),
                            FlSpot(16, 1),
                            FlSpot(17, 1),
                            FlSpot(18, 0),
                          ],
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.redAccent,
                              CustomColors.customSwathColor,
                              CustomColors.customContrastColor,
                              CustomColors.customContrastColor2,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          barWidth: 2,
                          isCurved: true,
                          curveSmoothness: 0.35,
                          isStrokeCapRound: true,
                          isStrokeJoinRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            //color: Colors.red.withOpacity(0.3),
                          ),
                          aboveBarData: BarAreaData(
                            show: true,
                            color: CustomColors.customContrastColor2.withOpacity(0.3),
                          ),
                          dotData: FlDotData(
                            show: true,
                            checkToShowDot: (spot, barData) {
                              return spot.x % 2 == 0;
                            },
                            getDotPainter: (spot, xPercentage, bar, index, {double? size}) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: CustomColors.customSwathColor,
                              );
                            },
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                          axisNameWidget: SizedBox(),
                        ),
                        rightTitles: AxisTitles(
                          axisNameWidget: SizedBox(),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('horas'),
                          axisNameSize: 20,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 23,
                          ),
                        ),
                        leftTitles: AxisTitles(
                            axisNameWidget: Text('Qtd'),
                            sideTitles: SideTitles(
                              showTitles: true,
                            )),
                      ),
                      maxX: 18,
                      minX: 8,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5,
                ),
                Text(
                  'Qtd. de pedidos x Qtd. separada.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 2.0,
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(toY: 10, color: CustomColors.customContrastColor),
                            BarChartRodData(toY: 8, color: CustomColors.customContrastColor2),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(toY: 8, color: CustomColors.customContrastColor),
                            BarChartRodData(toY: 5, color: CustomColors.customContrastColor2),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(toY: 2, color: CustomColors.customContrastColor),
                            BarChartRodData(toY: 0, color: CustomColors.customContrastColor2),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(toY: 9, color: CustomColors.customContrastColor),
                            BarChartRodData(toY: 7, color: CustomColors.customContrastColor2),
                          ],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(toY: 6, color: CustomColors.customContrastColor),
                            BarChartRodData(toY: 3, color: CustomColors.customContrastColor2),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          axisNameWidget: Text('Qtd.'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 25,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('Dias da Semana'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 23,
                            getTitlesWidget: (value, meta) {
                              Widget text;
                              switch (value.toInt()) {
                                case 0:
                                  text = const Text('Dom.');
                                  break;
                                case 1:
                                  text = const Text('Seg');
                                  break;
                                case 2:
                                  text = const Text('Ter');
                                  break;
                                case 3:
                                  text = const Text('Qua');
                                  break;
                                case 4:
                                  text = const Text('Qui');
                                  break;
                                case 5:
                                  text = const Text('Sex');
                                  break;
                                case 6:
                                  text = const Text('Sáb');
                                  break;
                                default:
                                  text = const Text('');
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                //space: 16,
                                child: text,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
