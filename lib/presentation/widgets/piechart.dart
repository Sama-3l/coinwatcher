// ignore_for_file: must_be_immutable

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/pieData.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  PieChart({super.key, required this.theme, required this.font, required this.currentMonthCategories});
  LightMode theme;
  FontFamily font;
  Categories currentMonthCategories;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {

  Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: SfCircularChart(annotations: [
        CircularChartAnnotation(
            widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\u20B9',
              style: widget.font.getPoppinsTextStyle(
                  color: widget.theme.textSecondary,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
            Text(func.getTotalAmount(widget.currentMonthCategories),
                style: widget.font.getPoppinsTextStyle(
                    color: widget.theme.textPrimary,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0)),
          ],
        ))
      ], series: <CircularSeries>[
        // Render pie chart
        DoughnutSeries<PieData, String>(
            dataSource: func.generatePieGraphData(widget.currentMonthCategories, widget.theme),
            pointColorMapper: (PieData data, _) => data.color,
            xValueMapper: (PieData data, _) => data.category,
            yValueMapper: (PieData data, _) => data.spent,
            radius: '100%'),
      ]),
    );
  }
}