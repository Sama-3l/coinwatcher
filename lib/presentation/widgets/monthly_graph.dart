import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class monthlyGraph extends StatelessWidget {
  final List<barDataMonthly> data;
  const monthlyGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<charts.Series<barDataMonthly, String>> series = [
      charts.Series(
          id: "monthly Expenses",
          data: data,
          domainFn: (barDataMonthly series, _) => series.month,
          measureFn: (barDataMonthly series, _) => series.spent,
          colorFn: (barDataMonthly series, _) => series.color)
    ];
    return Container(
      height: 0.156 * height,
      width: 0.78 * width,
      child: charts.BarChart(series, animate: true),
    );
  }
}
