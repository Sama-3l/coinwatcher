// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/widgets/trackerText.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpendingsTracker extends StatefulWidget {
  SpendingsTracker({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  State<SpendingsTracker> createState() => _SpendingsTrackerState();
}

class _SpendingsTrackerState extends State<SpendingsTracker> {
  AllExpenses allExpenses = AllExpenses();
  RecentExpenses recentExpenses = RecentExpenses();
  Methods func = Methods();
  late double currentAmount = func.getCurrentMonthAmount(recentExpenses);
  double totalBudget = 50000;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.theme.primaryAccent2,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TrackerText(
                  amount: totalBudget,
                  isTotal: true,
                  theme: widget.theme,
                  font: widget.font),
              TrackerText(
                  amount: currentAmount,
                  isTotal: false,
                  theme: widget.theme,
                  font: widget.font)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14.0,
              percent: currentAmount / totalBudget,
              barRadius: Radius.circular(7),
              backgroundColor: widget.theme.mainBackground,
              progressColor: widget.theme.primaryAccent3,
            ),
          ),
        ]),
      ),
    );
  }
}
