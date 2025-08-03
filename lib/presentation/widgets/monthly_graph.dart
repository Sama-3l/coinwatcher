import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyGraphFL extends StatefulWidget {
  final List<barDataMonthly> data;
  final User currentUser;

  const MonthlyGraphFL({
    super.key,
    required this.data,
    required this.currentUser,
  });

  @override
  State<MonthlyGraphFL> createState() => _MonthlyGraphFLState();
}

class _MonthlyGraphFLState extends State<MonthlyGraphFL> {
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final budget = func.monthlyBudget(widget.currentUser.dailyBudget);
    final maxY = _getMaxY(widget.data, budget);

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 0.2 * height,
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            maxY: maxY,
            alignment: BarChartAlignment.spaceAround,
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // 👈 Turn off Y-axis labels
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < widget.data.length) {
                      return Text(
                        widget.data[index].month,
                        style: const TextStyle(fontSize: 10),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            // extraLinesData: ExtraLinesData(
            //   horizontalLines: [
            //     HorizontalLine(
            //       y: budget.toDouble(),
            //       color: Colors.grey.shade500,
            //       strokeWidth: 1,
            //       dashArray: [
            //         5,
            //         3
            //       ],
            //       label: HorizontalLineLabel(
            //         show: true,
            //         alignment: Alignment.topRight,
            //         style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
            //         labelResolver: (_) => 'Budget',
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  double _getMaxY(List<barDataMonthly> data, double budget) {
    final maxSpent = data.map((e) => e.spent).reduce((a, b) => a > b ? a : b);
    return (maxSpent > budget ? maxSpent : budget) * 1.2;
  }

  double _getLabelInterval(List<barDataMonthly> data, double budget) {
    final maxY = _getMaxY(data, budget);
    const labelCount = 2; // Change to 3 for up to 3 Y-axis labels
    return (maxY / labelCount).ceilToDouble();
  }
}
