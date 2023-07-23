import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/appButton.dart';
import 'package:coinwatcher/presentation/widgets/daily_graph.dart';
import 'package:coinwatcher/presentation/widgets/monthly_graph.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpenseGraph extends StatefulWidget {
  ExpenseGraph(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});
  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  late Color _colorMonthly = widget.theme.primaryAccent1;
  late Color _colorDaily = widget.theme.mainBackground;
  int index = 0;
  Methods func = Methods();

  late List<barDataMonthly> monthly =
      func.initializeMonthlyGraphDatabase(widget.currentUser, widget.theme);

  late List<barDataDaily> daily =
      func.initializeDailyGraphDatabase(widget.currentUser, widget.theme);

  late final bgraph = [
    monthlyGraph(data: monthly),
    dailyGraph(data: daily),
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
