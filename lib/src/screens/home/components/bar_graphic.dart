import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';

class BarGraphic extends StatelessWidget {
  const BarGraphic({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
                        color: Colors.white,
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
    );
  }
}
