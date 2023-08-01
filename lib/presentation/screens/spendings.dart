import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
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
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 21, right: 21),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: wd.getSpendingsWidgets(
                  widget.currentUser, widget.theme, widget.font)),
        )),
      ),
    );
  }
}
