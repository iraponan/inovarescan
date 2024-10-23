import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';

class PizzaGraphicSeparacao extends StatefulWidget {
  const PizzaGraphicSeparacao({super.key, this.valueSeparado, this.valueNSeparado, this.subtitle, this.isPerc = false});

  final double? valueSeparado;
  final double? valueNSeparado;
  final String? subtitle;
  final bool? isPerc;

  @override
  State<PizzaGraphicSeparacao> createState() => _PizzaGraphicSeparacaoState();
}

class _PizzaGraphicSeparacaoState extends State<PizzaGraphicSeparacao> {
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (homeController) {
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                            homeController.touchedIndex.value = -1;
                            return;
                          }
                          homeController.touchedIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    startDegreeOffset: 75,
                    sections: List.generate(2, (i) {
                      final isTouched = i == homeController.touchedIndex.value;
                      final fontSize = isTouched ? 25.0 : 16.0;
                      final radius = isTouched ? 60.0 : 50.0;
                      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                      switch (i) {
                        case 0:
                          return PieChartSectionData(
                            color: CustomColors.customContrastColor,
                            value: widget.valueNSeparado,
                            title: widget.isPerc == true ? '${widget.valueNSeparado ?? 0}%' : widget.valueNSeparado.toString(),
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
                            value: widget.valueSeparado,
                            title: widget.isPerc == true ? '${widget.valueSeparado ?? 0}%' : widget.valueSeparado.toString(),
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
                '${widget.subtitle}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
