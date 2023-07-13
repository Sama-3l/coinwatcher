import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/presentation/widgets/appButton.dart';
import 'package:coinwatcher/presentation/widgets/daily_graph.dart';
import 'package:coinwatcher/presentation/widgets/monthly_graph.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseGraph extends StatefulWidget {
  ExpenseGraph({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

  // dummy data

  late final List<barDataMonthly> monthly = [
    barDataMonthly(
      month: "jan",
      spent: 4000,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "feb",
      spent: 2000,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "mar",
      spent: 3500,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "apr",
      spent: 3700,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "may",
      spent: 4500,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "june",
      spent: 6000,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "jul",
      spent: 1200,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "aug",
      spent: 4500,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "sep",
      spent: 9000,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataMonthly(
      month: "oct",
      spent: 1200,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
  ];
  late final List<barDataDaily> daily = [
    barDataDaily(
      day: "1",
      spent: 300,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "2",
      spent: 350,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "3",
      spent: 200,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "4",
      spent: 270,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "5",
      spent: 320,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "6",
      spent: 500,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "7",
      spent: 120,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "8",
      spent: 350,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "9",
      spent: 252,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
    barDataDaily(
      day: "10",
      spent: 520,
      color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
    ),
  ];

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  late Color _colorMonthly = widget.theme.primaryAccent1;
  late Color _colorDaily = widget.theme.mainBackground;
  int index = 0;
  late final bgraph = [
    monthlyGraph(data: widget.monthly),
    dailyGraph(data: widget.daily),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                    });
                  },
                  child: AppButton(
                    width: width,
                    height: height,
                    color: _colorMonthly,
                    theme: widget.theme,
                    font: widget.font,
                    text: 'monthly',
                  )),

              //daily

              GestureDetector(
                  // REPLACE WITH INKWELL
                  onTap: () {
                    setState(() {
                      _colorMonthly = widget.theme.mainBackground;
                      _colorDaily = widget.theme.primaryAccent1;
                      index = 1;
                    });
                  },
                  child: AppButton(
                    width: width,
                    height: height,
                    color: _colorDaily,
                    theme: widget.theme,
                    font: widget.font,
                    text: 'daily',
                  )),
            ],
          ),

          //  Bar Graph
          bgraph[index],
        ],
      ),
    );
  }
}
