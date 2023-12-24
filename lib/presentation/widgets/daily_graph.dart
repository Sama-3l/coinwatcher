// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../data/model/user.dart';

class dailyGraph extends StatefulWidget {
  final List<barDataDaily> data;
  User currentUser;
  dailyGraph({required this.data, required this.currentUser});

  @override
  State<dailyGraph> createState() => _dailyGraphState();
}

class _dailyGraphState extends State<dailyGraph> {
  Methods func = Methods();

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
    return SizedBox(
        height: 0.156 * height,
        width: 0.78 * width,
        child: charts.BarChart(
          series,
          animate: true,
          primaryMeasureAxis: charts.NumericAxisSpec(
            showAxisLine: true,
            tickProviderSpec:
                charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
          ),
          barRendererDecorator: charts.BarLabelDecorator<String>(),
          defaultRenderer: charts.BarRendererConfig(minBarLengthPx: 2),
          behaviors: [
            charts.RangeAnnotation([
              charts.LineAnnotationSegment(
                  widget.currentUser.dailyBudget, charts.RangeAnnotationAxisType.measure,
                  color: charts.MaterialPalette.gray.shade500),
            ]),
          ],
        ));
  }
}
