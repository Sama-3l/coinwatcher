//Add functions that decide what widget will be there in the UI

// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart' as UserModel;
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant.dart';

class WidgetDecider {
  List<Widget> getSpendingsWidgets(UserModel.User currentUser, LightMode theme, FontFamily font, BuildContext context) {
    List<Widget> columnChildren = [];
    Methods func = Methods();
    DateTime? temp;
    for (int i = 0; i < currentUser.allExpenses.allExpenses.length; i++) {
      if (i < currentUser.recentExpenses.recentExpenses.length) {
        if (i == 0) {
          columnChildren.add(Text(
            "Recent spendings",
            style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1),
          ));

          columnChildren.add(Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12),
            child: Text(
              func.getMonthandYear(date: currentUser.recentExpenses.recentExpenses[0].date),
              style: font.getPoppinsTextStyle(color: theme.textSecondary, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
          ));
        }

        if (temp == null || currentUser.recentExpenses.recentExpenses[i].date != temp) {
          columnChildren.add(Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              DateFormat('MMMM, dd').format(currentUser.recentExpenses.recentExpenses[i].date).toUpperCase(),
              style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0),
            ),
          ));
          temp = currentUser.recentExpenses.recentExpenses[i].date;
        }

        columnChildren.add(ExpenseBox(currentUser: currentUser, currentExpense: currentUser.recentExpenses.recentExpenses[i], theme: theme, font: font));
      } else {
        temp = null;
        if (i != 0) {
          if (currentUser.allExpenses.allExpenses[i - 1].date.month != currentUser.allExpenses.allExpenses[i].date.month) {
            columnChildren.add(Padding(
              padding: const EdgeInsets.only(left: 8, top: 0, bottom: 12),
              child: Text(
                func.getMonthandYear(date: currentUser.allExpenses.allExpenses[i].date),
                style: font.getPoppinsTextStyle(color: theme.textSecondary, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1),
              ),
            ));
          }
        }

        if (temp == null || currentUser.recentExpenses.recentExpenses[i].date != temp) {
          columnChildren.add(Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              DateFormat('MMMM, dd').format(currentUser.recentExpenses.recentExpenses[i].date).toUpperCase(),
              style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0),
            ),
          ));
          temp = currentUser.recentExpenses.recentExpenses[i].date;
        }

        columnChildren.add(ExpenseBox(currentUser: currentUser, currentExpense: currentUser.allExpenses.allExpenses[i], theme: theme, font: font));
      }
    }
    columnChildren.add(SizedBox(height: pagePadding));

    return columnChildren;
  }

  Widget showAmount(Expense expense, FontFamily font, LightMode theme) {
    Methods func = Methods();
    return Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        '\u20B9',
        style: font.getPoppinsTextStyle(color: theme.textSecondary, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1),
      ),
      AutoSizeText(
        expense.amount.ceil().toString(),
        style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.41),
      ),
      Text(
        func.decimalPart(expense.amount),
        style: font.getPoppinsTextStyle(color: theme.textSecondary, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: -0.41),
      ),
    ]);
  }

  List<Widget> getRecentSpendings(UserModel.User currentUser, LightMode theme, FontFamily font) {
    List<Widget> children = [];
    DateTime? temp;
    RecentExpenses recentExpenses = currentUser.recentExpenses;
    for (int i = 0; i < recentExpenses.recentExpenses.length; i++) {
      if (temp == null || recentExpenses.recentExpenses[i].date != temp) {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            DateFormat('MMMM, dd').format(recentExpenses.recentExpenses[i].date).toUpperCase(),
            style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0),
          ),
        ));
        temp = recentExpenses.recentExpenses[i].date;
      }
      children.add(ExpenseBox(currentUser: currentUser, currentExpense: recentExpenses.recentExpenses[i], theme: theme, font: font, forDashboard: true));
    }
    if (children.isEmpty) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "No recent spendings",
            style: font.getPoppinsTextStyle(color: theme.textHint, fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.41),
          ),
        ),
      ));
    }
    return children;
  }

  Padding textWidget(String text, FontFamily font, LightMode theme, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, bottom: 7),
      child: Text(
        text,
        style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: fontSize, fontWeight: FontWeight.w600, letterSpacing: -0.41),
      ),
    );
  }

  Future<bool> showSignOutDialog(BuildContext context, SharedPreferences prefs, FontFamily font, LightMode theme) async {
    bool signOut = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Sign Out Confirmation",
            style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.41),
          ),
          content: Text(
            "Are you sure you want to sign out?",
            style: font.getPoppinsTextStyle(color: theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: -0.41),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  // Close the dialog without signing out
                  signOut = false;
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: font.getPoppinsTextStyle(color: theme.primaryAccent3, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -0.41),
                )),
            TextButton(
              onPressed: () {
                prefs.clear();
                signOut = true;
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
              child: Text(
                "Sign Out",
                style: font.getPoppinsTextStyle(color: theme.primaryAccent3, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: -0.41),
              ),
            ),
          ],
        );
      },
    );
    return signOut;
  }
}
