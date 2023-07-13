//Put normal functions here that are supposed to run logic

import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Methods {
  String getMonthandYear({required DateTime date, bool commaReq = true}) {
    return commaReq
        ? DateFormat('MMMM, yyyy').format(date)
        : DateFormat('MMMM d').format(date);
  }

  String decimalPart(double amount) {
    return ".${(amount.ceilToDouble() - amount).toInt().toString().padLeft(2, '0')}";
  }

  double getCurrentMonthAmount(RecentExpenses recentExpenses) {
    double sum = 0;
    for (int i = 0; i < recentExpenses.recentExpenses.length; i++) {
      sum = sum + recentExpenses.recentExpenses[i].amount;
    }
    return sum;
  }

  RecentExpenses getRecentExpenses(AllExpenses allExpenses) {
    RecentExpenses recentExpenses = RecentExpenses();
    if (allExpenses.allExpenses[0].date.month == DateTime.now().month) {
      for (int i = 0; i < allExpenses.allExpenses.length; i++) {
        if (allExpenses.allExpenses[i].date.month == DateTime.now().month) {
          recentExpenses.recentExpenses.add(allExpenses.allExpenses[i]);
        } else {
          break;
        }
      }
    }

    return recentExpenses;
  }

  double monthlyBudget(double dailyBudget) {
    return dailyBudget *
            DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }
}
