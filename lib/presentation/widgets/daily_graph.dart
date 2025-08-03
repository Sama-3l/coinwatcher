import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../data/model/user.dart';

class DailyGraphFL extends StatefulWidget {
  final List<barDataDaily> data;
  final User currentUser;

  const DailyGraphFL({super.key, required this.data, required this.currentUser});

  @override
  State<DailyGraphFL> createState() => _DailyGraphFLState();
}

class _DailyGraphFLState extends State<DailyGraphFL> {
  Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final barGroups = widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.spent.toDouble(),
            color: item.color,
            width: 14,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    final maxY = _getMaxY(widget.data, widget.currentUser.dailyBudget);
    final yInterval = (maxY / 4).ceilToDouble();

    return SizedBox(
      height: 0.22 * height,
      width: 0.9 * width,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barGroups: barGroups,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                interval: yInterval,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      value.toInt().toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < widget.data.length) {
                    return Text(widget.data[index].day, style: const TextStyle(fontSize: 10));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: true),
          extraLinesData: ExtraLinesData(horizontalLines: [
            HorizontalLine(
              y: widget.currentUser.dailyBudget.toDouble(),
              color: Colors.grey.shade500,
              strokeWidth: 1,
              dashArray: [
                5,
                3
              ],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                labelResolver: (_) => 'Budget',
              ),
            ),
          ]),
        ),
      ),
    );
  }

  double _getMaxY(List<barDataDaily> data, double budget) {
    final maxSpent = data.map((e) => e.spent).reduce((a, b) => a > b ? a : b);
    return (maxSpent > budget ? maxSpent : budget) * 1.2;
  }
}
