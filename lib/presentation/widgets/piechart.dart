import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/pieData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  PieChart({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

  final List<PieData> data = [
    PieData(category: "foodnDrinks", spent: 2500, color: Color(0xffA6D8A9)),
    PieData(category: "hnf", spent: 1000, color: Color(0xff94B8FA)),
    PieData(category: "personalcare", spent: 2000, color: Color(0xffF29DAA)),
    PieData(category: "essentials", spent: 1500, color: Color(0xffCAAAE3)),
    PieData(category: "education", spent: 1700, color: Color(0xff9498F1)),
    PieData(category: "misc", spent: 1600, color: Color(0xffEFA68F)),
  ];
  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(annotations: [
        CircularChartAnnotation(
            widget: Container(
                child: Text('\u{20B9}${10300}',
                    style: widget.font.getPoppinsTextStyle(
                        color: widget.theme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0))))
      ], series: <CircularSeries>[
        // Render pie chart
        DoughnutSeries<PieData, String>(
            dataSource: widget.data,
            pointColorMapper: (PieData data, _) => data.color,
            xValueMapper: (PieData data, _) => data.category,
            yValueMapper: (PieData data, _) => data.spent,
            radius: '50%'),
      ]),
    );
  }
}
