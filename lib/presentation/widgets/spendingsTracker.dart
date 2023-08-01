// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/widgets/changeMonthlyBudget.dart';
import 'package:coinwatcher/presentation/widgets/trackerText.dart';
import 'package:coinwatcher/routes/monthlyPopUpRoute.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpendingsTracker extends StatefulWidget {
  SpendingsTracker(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<SpendingsTracker> createState() => _SpendingsTrackerState();
}

class _SpendingsTrackerState extends State<SpendingsTracker> {
  Methods func = Methods();

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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(HeroDialogPoPRoute(
                      builder: (context) => Align(
                          alignment: Alignment.bottomCenter,
                          child: ChangeBudget(
                              currentUser: widget.currentUser,
                              theme: widget.theme,
                              font: widget.font))));
                },
                child: TrackerText(
                    amount: func.monthlyBudget(widget.currentUser.dailyBudget),
                    isTotal: true,
                    theme: widget.theme,
                    font: widget.font),
              ),
              TrackerText(
                  amount: widget.currentUser.thisMonthSpent,
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
              percent: (widget.currentUser.thisMonthSpent /
                          (func.monthlyBudget(widget.currentUser.dailyBudget) ==
                                  0
                              ? 1
                              : func.monthlyBudget(
                                  widget.currentUser.dailyBudget))) ==
                      1
                  ? 1
                  : widget.currentUser.thisMonthSpent /
                      (func.monthlyBudget(widget.currentUser.dailyBudget) == 0
                          ? 1
                          : func.monthlyBudget(widget.currentUser.dailyBudget)),
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
