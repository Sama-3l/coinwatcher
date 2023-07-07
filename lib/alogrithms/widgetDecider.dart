//Add functions that decide what widget will be there in the UI

import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

class WidgetDecider {
  Widget getSpendingsWidgets(
      AllExpenses allExpenses, RecentExpenses recentExpenses, int index) {
    List<Widget> columnChildren = [];

    if (index < recentExpenses.recentExpenses.length) {
      if (index == 0) {
        columnChildren.add(Text("Recent Spendings"));
      }
    }

    if (columnChildren.length == 1) {
      return columnChildren[0];
    } else {
      return Column(children: columnChildren);
    }
  }
}
