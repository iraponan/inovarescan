import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/home.dart';
import 'package:inovarescan/src/helpers/mssql/querys_columns.dart';

class LinearGraphic extends StatelessWidget {
  const LinearGraphic({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: homeController.qttPerHour.asMap().entries.map((e) {
                return FlSpot(e.value[QueryQtdPorHoraColumnsNames.hour].toDouble(), e.value[QueryQtdPorHoraColumnsNames.qtdSeparada].toDouble());
              }).toList(),
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
                color: CustomColors.customContrastColor2.withOpacity(0.3),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, xPercentage, bar, index, {double? size}) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: CustomColors.customSwathColor,
                  );
                },
              ),
            ),
          ],
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              axisNameWidget: SizedBox(),
            ),
            rightTitles: AxisTitles(
              axisNameWidget: SizedBox(),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text('horas ao decorrer do dia'),
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
                reservedSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
