import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';
import 'package:inovarescan/src/screens/home/components/dates_dialog.dart';
import 'package:inovarescan/src/screens/home/components/indicator.dart';

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
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            setState(() {
                                              if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: List.generate(2, (i) {
                                          final isTouched = i == touchedIndex;
                                          final fontSize = isTouched ? 25.0 : 16.0;
                                          final radius = isTouched ? 60.0 : 50.0;
                                          const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                                          switch (i) {
                                            case 0:
                                              return PieChartSectionData(
                                                color: CustomColors.customContrastColor,
                                                value: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percNSeparado],
                                                title: '${homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percNSeparado] ?? 0}%',
                                                radius: radius,
                                                titleStyle: TextStyle(
                                                  fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: shadows,
                                                ),
                                              );
                                            case 1:
                                              return PieChartSectionData(
                                                color: CustomColors.customSwathColor,
                                                value: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percSeparado],
                                                title: '${homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.percSeparado] ?? 0}%',
                                                radius: radius,
                                                titleStyle: TextStyle(
                                                  fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: shadows,
                                                ),
                                              );
                                            default:
                                              throw Error();
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Percentual',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                            setState(() {
                                              if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: List.generate(2, (i) {
                                          final isTouched = i == touchedIndex;
                                          final fontSize = isTouched ? 25.0 : 16.0;
                                          final radius = isTouched ? 60.0 : 50.0;
                                          const shadows = [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 2,
                                            ),
                                          ];
                                          switch (i) {
                                            case 0:
                                              return PieChartSectionData(
                                                color: CustomColors.customContrastColor,
                                                value: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoNSeparado],
                                                title:
                                                    '${homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoNSeparado] == null ? 0 : homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoNSeparado].toInt()}',
                                                radius: radius,
                                                titleStyle: TextStyle(
                                                  fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: shadows,
                                                ),
                                              );
                                            case 1:
                                              return PieChartSectionData(
                                                color: CustomColors.customSwathColor,
                                                value: homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoSeparado],
                                                title:
                                                    '${homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoSeparado] == null ? 0 : homeController.percQtdSeparacoes[QuerysPercQtdSeparacoesColumnsNames.qtdPedidoSeparado].toInt()}',
                                                radius: radius,
                                                titleStyle: TextStyle(
                                                  fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: shadows,
                                                ),
                                              );
                                            default:
                                              throw Error();
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Quantidade',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
                AspectRatio(
                  aspectRatio: 1,
                  child: BarChart(
                    BarChartData(
                      barGroups: homeController.qtdPorSeparador.asMap().entries.map((e) {
                        return BarChartGroupData(
                          x: e.key + 1,
                          barRods: [
                            BarChartRodData(
                              toY: e.value[QueryQtdPorSeparadorColumnsNames.qtdSeparada].toDouble(),
                              color: CustomColors.customContrastColor,
                            ),
                          ],
                        );
                      }).toList(),
                      gridData: FlGridData(show: false),
                      alignment: BarChartAlignment.spaceBetween,
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => CustomColors.customContrastColor2,
                          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${homeController.qtdPorSeparador.elementAt(groupIndex)[QueryQtdPorSeparadorColumnsNames.separador]}\n',
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              children: <TextSpan>[
                                TextSpan(
                                  text: (rod.toY).toInt().toString(),
                                  style: const TextStyle(
                                    color: Colors.white, //widget.touchedBarColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          axisNameWidget: Text('Qtd.'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 33,
                          ),
                        ),
                        topTitles: AxisTitles(
                          axisNameWidget: Text(''),
                        ),
                        rightTitles: AxisTitles(
                          axisNameWidget: Text(''),
                        ),
                        bottomTitles: AxisTitles(
                          axisNameWidget: Text('Separadores'),
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 120,
                            getTitlesWidget: (value, meta) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 8,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    homeController.qtdPorSeparador.elementAt(value.toInt() - 1)[QueryQtdPorSeparadorColumnsNames.separador],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
