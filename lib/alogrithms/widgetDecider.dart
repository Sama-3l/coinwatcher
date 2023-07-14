//Add functions that decide what widget will be there in the UI

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/expense.dart';
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
            "Recent spendings",
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ));

          columnChildren.add(Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              func.getMonthandYear(date: recentExpenses.recentExpenses[0].date),
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
        if (i != 0) {
          if (allExpenses.allExpenses[i - 1].date.month !=
              allExpenses.allExpenses[i].date.month) {
            columnChildren.add(Padding(
              padding: const EdgeInsets.only(left: 8, top: 0, bottom: 12),
              child: Text(
                func.getMonthandYear(date: allExpenses.allExpenses[i].date),
                style: font.getPoppinsTextStyle(
                    color: theme.textSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1),
              ),
            ));
          }
        }
        columnChildren.add(ExpenseBox(
            currentExpense: allExpenses.allExpenses[i],
            theme: theme,
            font: font));
      }
    }

    return columnChildren;
  }

  Widget showAmount(Expense expense, FontFamily font, LightMode theme) {
    Methods func = Methods();
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\u20B9',
            style: font.getPoppinsTextStyle(
                color: theme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          Text(
            expense.amount.ceil().toString(),
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.41),
          ),
          Text(
            func.decimalPart(expense.amount),
            style: font.getPoppinsTextStyle(
                color: theme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.41),
          ),
        ]);
  }

  List<Widget> getRecentSpendings(
      RecentExpenses recentExpenses, LightMode theme, FontFamily font) {
    List<Widget> children = [];
    for (int i = 0; i < recentExpenses.recentExpenses.length; i++) {
      children.add(ExpenseBox(
          currentExpense: recentExpenses.recentExpenses[i],
          theme: theme,
          font: font,
          forDashboard: true));
    }
    return children;
  }

  Widget showLegendAmounts(double amount, FontFamily font, LightMode theme) {
    Methods func = Methods();
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\u20B9',
            style: font.getPoppinsTextStyle(
                color: theme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          Text(
            amount.ceil().toString(),
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.41),
          ),
          Text(
            func.decimalPart(amount),
            style: font.getPoppinsTextStyle(
                color: theme.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.41),
          ),
        ]);
  }
}
