import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_outlined,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                          BarChartRodData(toY: 10, color: Colors.redAccent),
                          BarChartRodData(toY: 8, color: Colors.greenAccent),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(toY: 8, color: Colors.redAccent),
                          BarChartRodData(toY: 5, color: Colors.greenAccent),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(toY: 2, color: Colors.redAccent),
                          BarChartRodData(toY: 0, color: Colors.greenAccent),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(toY: 9, color: Colors.redAccent),
                          BarChartRodData(toY: 7, color: Colors.greenAccent),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(toY: 6, color: Colors.redAccent),
                          BarChartRodData(toY: 3, color: Colors.greenAccent),
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
                            Colors.yellowAccent,
                            Colors.greenAccent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        barWidth: 8,
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
                          //color: Colors.green.withOpacity(0.3),
                        ),
                        // dotData: FlDotData(
                        //   show: true,
                        //   checkToShowDot: (spot, barData) {
                        //     return spot.x % 2 == 0;
                        //   },
                        //   getDotPainter: (spot, xPercentage, bar, index, {double? size}) {
                        //     return FlDotCrossPainter(
                        //       size: 20,
                        //       color: [
                        //         Colors.red,
                        //         Colors.blue,
                        //         Colors.green,
                        //       ][index % 3],
                        //     );
                        //   },
                        // ),
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
                '% de separações feitas no dia.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AspectRatio(
                aspectRatio: 2.0,
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
                            color: Colors.redAccent,
                            value: 30,
                            title: '30%',
                            radius: radius,
                            titleStyle: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: shadows,
                            ),
                          );
                        case 1:
                          return PieChartSectionData(
                            color: Colors.greenAccent,
                            value: 70,
                            title: '70%',
                            radius: radius,
                            titleStyle: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
            ],
          ),
        ),
      ),
    );
  }
}
