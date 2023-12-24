// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../data/model/user.dart';

class monthlyGraph extends StatefulWidget {
  final List<barDataMonthly> data;
  User currentUser;
  monthlyGraph({required this.data, required this.currentUser});

  @override
  State<monthlyGraph> createState() => _monthlyGraphState();
}

class _monthlyGraphState extends State<monthlyGraph> {
  double threshold = 5000;
  Methods func = Methods();

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
      child: SizedBox(
          height: 0.156 * height,
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
                    func.monthlyBudget(widget.currentUser.dailyBudget), charts.RangeAnnotationAxisType.measure,
                    color: charts.MaterialPalette.gray.shade500),
              ]),
            ],
          )),
    );
  }
}
