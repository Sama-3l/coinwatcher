// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class monthlyGraph extends StatefulWidget {
  final List<barDataMonthly> data;
  const monthlyGraph({required this.data});

  @override
  State<monthlyGraph> createState() => _monthlyGraphState();
}

class _monthlyGraphState extends State<monthlyGraph> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<charts.Series<barDataMonthly, String>> series = [
      charts.Series(
          id: "monthly Expenses",
          data: widget.data,
          domainFn: (barDataMonthly series, _) => series.month,
          measureFn: (barDataMonthly series, _) => series.spent,
          colorFn: (barDataMonthly series, _) => series.color)
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
          height: 0.156 * height,
          child: charts.BarChart(
            series,
            animate: true,
          )),
    );
  }
}
