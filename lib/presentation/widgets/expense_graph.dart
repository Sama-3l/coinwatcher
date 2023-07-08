import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/presentation/widgets/daily_graph.dart';
import 'package:coinwatcher/presentation/widgets/monthly_graph.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class expenseGraph extends StatefulWidget {
  expenseGraph({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

  // dummy data

  final List<barDataMonthly> monthly = [
    barDataMonthly(
      month: "jan",
      spent: 4000,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataMonthly(
      month: "feb",
      spent: 2000,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataMonthly(
      month: "march",
      spent: 3500,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataMonthly(
      month: "apr",
      spent: 3700,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataMonthly(
      month: "may",
      spent: 4500,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
  ];
  final List<barDataDaily> daily = [
    barDataDaily(
      day: "1",
      spent: 300,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataDaily(
      day: "2",
      spent: 350,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataDaily(
      day: "3",
      spent: 200,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataDaily(
      day: "4",
      spent: 270,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    ),
    barDataDaily(
      day: "5",
      spent: 320,
      color: charts.ColorUtil.fromDartColor(Color(0xA6D8A9)),
    )
  ];

  @override
  State<expenseGraph> createState() => _expenseGraphState();
}

class _expenseGraphState extends State<expenseGraph> {
  late var _colorMonthly = widget.theme.primaryAccent1;
  late var _colorDaily = widget.theme.mainBackground;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final bgraph = [
      monthlyGraph(data: widget.monthly),
      dailyGraph(data: widget.daily),
    ];
    int index = 0;
    return Container(
      height: 0.25 * height,
      width: 0.9 * width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.theme.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //  navigator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //monthly
              GestureDetector(
                onTap: () {
                  setState(() {
                    _colorMonthly = widget.theme.primaryAccent1;
                    _colorDaily = widget.theme.mainBackground;
                    index = 0;
                    newprint(index);
                  });
                },
                child: Container(
                  width: 0.24 * width,
                  height: 0.03 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _colorMonthly,
                  ),
                  child: Center(
                    child: Text(
                      'Monthly',
                      style: widget.font.getPoppinsTextStyle(
                        color: widget.theme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),

              //daily

              GestureDetector(
                // REPLACE WITH INKWELL
                onTap: () {
                  setState(() {
                    _colorMonthly = widget.theme.mainBackground;
                    _colorDaily = widget.theme.primaryAccent1;
                    index = 1;
                    newprint(index);
                  });
                },
                child: Container(
                  width: 0.24 * width,
                  height: 0.03 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: _colorDaily,
                  ),
                  child: Center(
                    child: Text(
                      'Daily',
                      style: widget.font.getPoppinsTextStyle(
                        color: widget.theme.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //  Bar Graph
          bgraph[index],
        ],
      ),
    );
  }
}

void newprint(int i) {
  print(i);
}
