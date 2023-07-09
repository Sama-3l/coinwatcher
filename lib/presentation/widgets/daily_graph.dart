import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class dailyGraph extends StatefulWidget {
  final List<barDataDaily> data;
  const dailyGraph({required this.data});

  @override
  State<dailyGraph> createState() => _dailyGraphState();
}

class _dailyGraphState extends State<dailyGraph> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<charts.Series<barDataDaily, String>> series = [
      charts.Series(
          id: "Daily Expenses",
          data: widget.data,
          domainFn: (barDataDaily series, _) => series.day,
          measureFn: (barDataDaily series, _) => series.spent,
          colorFn: (barDataDaily series, _) => series.color)
    ];
    return Container(
      height: 0.156 * height,
      width: 0.78 * width,
      child: charts.BarChart(series, animate: true),
    );
  }
}
