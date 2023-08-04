// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expense_graph.dart';
import 'package:coinwatcher/presentation/widgets/spendingsTracker.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Methods func = Methods();
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 21, right: 21),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      func.getMonthandYear(date: DateTime.now()),
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: SpendingsTracker(
                      theme: widget.theme,
                      font: widget.font,
                      currentUser: widget.currentUser,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Analytics',
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: ExpenseGraph(
                          theme: widget.theme,
                          font: widget.font,
                          currentUser: widget.currentUser)),
                  //Analytics
                  //View more button -> Diverts to the analytics tab
                  widget.currentUser.recentExpenses.recentExpenses.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Recent spendings',
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textSecondary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container()),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: wd.getRecentSpendings(
                          widget.currentUser.recentExpenses,
                          widget.theme,
                          widget.font))
                ]),
          ),
        ),
      ),
    );
  }
}
