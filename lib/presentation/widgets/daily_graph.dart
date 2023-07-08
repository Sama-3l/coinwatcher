import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

class dailyGraph extends StatelessWidget {
  final List<barDataDaily> data;
  const dailyGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<barDataDaily, String>> series = [
      charts.Series(
          id: "Daily Expenses",
          data: data,
          domainFn: (barDataDaily series, _) => series.day,
          measureFn: (barDataDaily series, _) => series.spent,
          colorFn: (barDataDaily series, _) => series.color)
    ];
    return charts.BarChart(series, animate: true);
  }
}
