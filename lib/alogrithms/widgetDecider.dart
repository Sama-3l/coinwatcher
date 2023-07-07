//Add functions that decide what widget will be there in the UI

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseBox.dart';
import 'package:flutter/material.dart';

class WidgetDecider {
  List<Widget> getSpendingsWidgets(AllExpenses allExpenses,
      RecentExpenses recentExpenses, LightMode theme, FontFamily font) {
    List<Widget> columnChildren = [];
    Methods func = Methods();

    for (int i = 0; i < allExpenses.allExpenses.length; i++) {
      if (i < recentExpenses.recentExpenses.length) {
        if (i == 0) {
          columnChildren.add(Text(
            "Recent Spendings",
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ));

          columnChildren.add(Padding(
            padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
            child: Text(
              func.getMonthandYear(date: recentExpenses.recentExpenses[0].date, commaReq: false),
              style: font.getPoppinsTextStyle(
                  color: theme.textSecondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ));
        }

        columnChildren.add(ExpenseBox(
            currentExpense: recentExpenses.recentExpenses[i],
            theme: theme,
            font: font));
      } else {
        columnChildren.add(ExpenseBox(
            currentExpense: allExpenses.allExpenses[i],
            theme: theme,
            font: font));
      }
    }

    return columnChildren;
  }
}
