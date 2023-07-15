//Put normal functions here that are supposed to run logic

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:math';

import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../business_logic/blocs/datePicker/date_picker_bloc.dart';
import '../business_logic/blocs/updateExpense/update_expense_bloc.dart';
import '../data/repositories/months.dart';

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

  Future<DateTime?> editDate(
      BuildContext context, DateTime initialDate, LightMode theme) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      ),
      firstDate: DateTime(
        initialDate.year,
        initialDate.month - 1,
        initialDate.day,
      ),
      lastDate: DateTime(
        initialDate.year + 5,
        initialDate.month,
        initialDate.day,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[800],
            colorScheme: ColorScheme.light(
              primary: theme.mainBackground,
              onPrimary: theme.textPrimary,
              onSurface: theme.activeNavBarButton,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: theme.activeNavBarButton,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    BlocProvider.of<DatePickerBloc>(context).add(UpdateDateEvent());

    return picked;
  }

  String monthCommaYear(DateTime date) {
    return DateFormat('MMMM, yyyy').format(date);
  }

  void addMonthnCategories(User currentUser, Expense expense) {
    // Check if month exists
    print(currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!
        .categories.categories[expense.category]);
    if (currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] != null) {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent =
          currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!
                  .totalSpent +
              expense.amount;

      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories
          .categories[expense.category]!.amount = currentUser
              .monthsDB
              .allMonths[monthCommaYear(expense.date)]!
              .categories
              .categories[expense.category]!
              .amount +
          expense.amount;
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(
          date: DateTime(expense.date.year, expense.date.month),
          totalSpent: expense.amount,
          categories: Categories());
    }
  }

  void loadCategories(User currentUser, Expense expense) {
    currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories
        .categories[expense.category]!.amount = currentUser
            .monthsDB
            .allMonths[monthCommaYear(expense.date)]!
            .categories
            .categories[expense.category]!
            .amount +
        expense.amount;
  }

  //To initialize months can remove later it's better to just add a single entry as we actually need to do.
  void loadMonths(User currentUser) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    for (int i = allExpenses.length - 1; i >= 0; i--) {
      if(DateTime.now().month == allExpenses[i].date.month){
        currentUser.thisMonthSpent = currentUser.thisMonthSpent + allExpenses[i].amount;
      }
      if (currentUser.monthsDB.allMonths.isNotEmpty) {
        if (currentUser
                .monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] !=
            null) {
          currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)]!
              .totalSpent = currentUser.monthsDB
                  .allMonths[monthCommaYear(allExpenses[i].date)]!.totalSpent +
              allExpenses[i].amount;
          print(allExpenses[i].expenseName);
          loadCategories(currentUser, allExpenses[i]);
        } else {
          currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] =
              Month(
                  date: DateTime(
                      allExpenses[i].date.year, allExpenses[i].date.month),
                  totalSpent: allExpenses[i].amount,
                  categories: Categories());
          addMonthnCategories(currentUser, allExpenses[i]);
        }
      } else {
        currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] =
            Month(
                date: DateTime(
                    allExpenses[i].date.year, allExpenses[i].date.month),
                totalSpent: allExpenses[i].amount,
                categories: Categories());
        addMonthnCategories(currentUser, allExpenses[i]);
      }
    }
  }

  void addToMonthDB(User currentUser, Expense expense) {
    if (currentUser.monthsDB.allMonths.isNotEmpty) {
      // print(currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]);
      if (currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] !=
          null) {
        currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!
            .totalSpent = currentUser
                .monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent +
            expense.amount;
        loadCategories(currentUser, expense);
      } else {
        currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(
            date: DateTime(expense.date.year, expense.date.month),
            totalSpent: expense.amount,
            categories: Categories());
        addMonthnCategories(currentUser, expense);
      }
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(
          date: DateTime(expense.date.year, expense.date.month),
          totalSpent: expense.amount,
          categories: Categories());
      addMonthnCategories(currentUser, expense);
    }
  }

  void printBetterJson(String json) {
    String d = "";
    for (int i = 0; i < json.length; i++) {
      if (json[i] != ',') {
        d = d + json[i];
      } else {
        print("$d,");
        d = "";
      }
    }
  }

  void addExpenseFab(
      User currentUser, Expense thisExpense, BuildContext context) {
    if(DateTime.now().month == thisExpense.date.month){
      currentUser.thisMonthSpent = currentUser.thisMonthSpent + thisExpense.amount;
    }
    print('\n\n');
    currentUser.allExpenses.allExpenses.insert(0, thisExpense);
    currentUser.recentExpenses = getRecentExpenses(currentUser.allExpenses);
    addToMonthDB(currentUser, thisExpense);
    printBetterJson(
        "${currentUser.toJSON()}");
    Navigator.of(context).pop();
    BlocProvider.of<UpdateExpenseBloc>(context).add(ExpenseChangedEvent());
  }
}
