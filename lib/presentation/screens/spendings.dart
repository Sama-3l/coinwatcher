import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

class Spendings extends StatefulWidget {
  Spendings({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  State<Spendings> createState() => _SpendingsState();
}

class _SpendingsState extends State<Spendings> {

  AllExpenses allExpenses = AllExpenses();
  RecentExpenses recentExpenses = RecentExpenses();
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: ListView.builder(itemBuilder: (context, index) {}),
    );
  }
}
