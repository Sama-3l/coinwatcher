// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:flutter/material.dart';

class Spendings extends StatefulWidget {
  Spendings({super.key, required this.theme, required this.font, required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<Spendings> createState() => _SpendingsState();
}

class _SpendingsState extends State<Spendings> {
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: SafeArea(
        child: widget.currentUser.allExpenses.allExpenses.isEmpty
            ? Padding(
                padding: EdgeInsets.only(top: 30, left: 21, right: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent spendings",
                      style: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1),
                    ),
                    Expanded(
                      child: Center(
                          child: Text(
                        "No spendings yet",
                        style: widget.font.getPoppinsTextStyle(color: widget.theme.textHint, fontSize: 25, fontWeight: FontWeight.w600, letterSpacing: 1),
                      )),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 21, right: 21),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: wd.getSpendingsWidgets(widget.currentUser, widget.theme, widget.font, context)),
              )),
      ),
    );
  }
}
