import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/pieData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  PieChart({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

  late final List<PieData> data = [
    PieData(category: "foodnDrinks", spent: 2500, color: theme.foodNDrinks),
    PieData(category: "hnf", spent: 1000, color: theme.hnF),
    PieData(category: "personalcare", spent: 2000, color: theme.personalCare),
    PieData(category: "essentials", spent: 1500, color: theme.essentials),
    PieData(category: "education", spent: 1700, color: theme.education),
    PieData(category: "misc", spent: 1600, color: theme.misc),
  ];
  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
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
            Text('${10300}',
                style: widget.font.getPoppinsTextStyle(
                    color: widget.theme.textPrimary,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0)),
          ],
        ))
      ], series: <CircularSeries>[
        // Render pie chart
        DoughnutSeries<PieData, String>(
            dataSource: widget.data,
            pointColorMapper: (PieData data, _) => data.color,
            xValueMapper: (PieData data, _) => data.category,
            yValueMapper: (PieData data, _) => data.spent,
            radius: '80%'),
      ]),
    );
  }
}
