//Put normal functions here that are supposed to run logic

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:math';

import 'package:coinwatcher/business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/data/model/dayExpense.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/model/pieData.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../business_logic/blocs/datePicker/date_picker_bloc.dart';
import '../business_logic/blocs/updateExpense/update_expense_bloc.dart';
import '../data/repositories/months.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../services/server.dart';

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
    if (allExpenses.allExpenses.isNotEmpty) {
      if (allExpenses.allExpenses[0].date.month == DateTime.now().month) {
        for (int i = 0; i < allExpenses.allExpenses.length; i++) {
          if (allExpenses.allExpenses[i].date.month == DateTime.now().month) {
            recentExpenses.recentExpenses.add(allExpenses.allExpenses[i]);
          } else {
            break;
          }
        }
      } else if (allExpenses.allExpenses.length > 1) {
        var currentMonth = allExpenses.allExpenses[0].date.month;
        for (int i = 0; i < allExpenses.allExpenses.length; i++) {
          if (allExpenses.allExpenses[i].date.month == currentMonth) {
            recentExpenses.recentExpenses.add(allExpenses.allExpenses[i]);
          } else {
            break;
          }
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

  void addMonthnCategories(User currentUser, Expense expense, LightMode theme) {
    // Check if month exists
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
          categories: Categories(theme: theme));
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
  void loadMonths(User currentUser, LightMode theme) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    if (allExpenses.isNotEmpty) {
      for (int i = allExpenses.length - 1; i >= 0; i--) {
        if (DateTime.now().month == allExpenses[i].date.month) {
          currentUser.thisMonthSpent =
              currentUser.thisMonthSpent + allExpenses[i].amount;
        }
        if (currentUser.monthsDB.allMonths.isNotEmpty) {
          if (currentUser
                  .monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] !=
              null) {
            currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)]!
                .totalSpent = currentUser
                    .monthsDB
                    .allMonths[monthCommaYear(allExpenses[i].date)]!
                    .totalSpent +
                allExpenses[i].amount;
            loadCategories(currentUser, allExpenses[i]);
          } else {
            currentUser
                    .monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] =
                Month(
                    date: DateTime(
                        allExpenses[i].date.year, allExpenses[i].date.month),
                    totalSpent: allExpenses[i].amount,
                    categories: Categories(theme: theme));
            addMonthnCategories(currentUser, allExpenses[i], theme);
          }
        } else {
          currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] =
              Month(
                  date: DateTime(
                      allExpenses[i].date.year, allExpenses[i].date.month),
                  totalSpent: allExpenses[i].amount,
                  categories: Categories(theme: theme));
          addMonthnCategories(currentUser, allExpenses[i], theme);
        }
      }
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(DateTime.now())] = Month(
          date: DateTime(DateTime.now().year, DateTime.now().month),
          totalSpent: 0.0,
          categories: Categories(theme: theme));
    }
  }

  void addToMonthDB(User currentUser, Expense expense, LightMode theme) {
    if (currentUser.monthsDB.allMonths.isNotEmpty) {
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
            categories: Categories(theme: theme));
        addMonthnCategories(currentUser, expense, theme);
      }
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(
          date: DateTime(expense.date.year, expense.date.month),
          totalSpent: expense.amount,
          categories: Categories(theme: theme));
      addMonthnCategories(currentUser, expense, theme);
    }
  }

  void loadDays(User currentUser) {
    List<Expense> allExpenses =
        currentUser.allExpenses.allExpenses.reversed.toList();
    if (allExpenses.isNotEmpty) {
      currentUser.daysDB
              .allDays[allExpenses[0].date.day.toString().padLeft(2, '0')] =
          DayExpense(date: allExpenses[0].date, amount: allExpenses[0].amount);
      for (int i = 0; i < 10; i++) {
        currentUser.daysDB.allDays[allExpenses[0]
                .date
                .subtract(Duration(days: i))
                .day
                .toString()
                .padLeft(2, '0')] =
            DayExpense(
                date: allExpenses[0].date.subtract(Duration(days: i)),
                amount: 0.0);
      }
      for (int i = 0; i < allExpenses.length; i++) {
        if (currentUser.daysDB
                .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')] !=
            null) {
          if (currentUser
                  .daysDB
                  .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!
                  .date
                  .difference(allExpenses[i].date)
                  .inDays ==
              0) {
            double currentAmount = currentUser
                .daysDB
                .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!
                .amount;
            currentUser.daysDB.allDays[
                    allExpenses[i].date.day.toString().padLeft(2, '0')] =
                DayExpense(
                    date: allExpenses[i].date,
                    amount: currentAmount + allExpenses[i].amount);
          }
        }
      }
    }
  }

  void addToDayDb(User currentUser) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    currentUser.daysDB.allDays.clear();
    for (int i = 0; i < 10; i++) {
      currentUser.daysDB.allDays[allExpenses[0]
              .date
              .subtract(Duration(days: i))
              .day
              .toString()
              .padLeft(2, '0')] =
          DayExpense(
              date: allExpenses[0].date.subtract(Duration(days: i)),
              amount: 0.0);
    }
    for (int i = 0; i < allExpenses.length; i++) {
      if (currentUser.daysDB
              .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')] !=
          null) {
        if (currentUser
                .daysDB
                .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!
                .date
                .difference(allExpenses[i].date)
                .inDays ==
            0) {
          currentUser
              .daysDB
              .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!
              .amount = currentUser
                  .daysDB
                  .allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!
                  .amount +
              allExpenses[i].amount;
        }
      }
    }
  }

  void addExpenseFab(User currentUser, Expense thisExpense,
      BuildContext context, LightMode theme) {
    if (DateTime.now().month == thisExpense.date.month) {
      currentUser.thisMonthSpent =
          currentUser.thisMonthSpent + thisExpense.amount;
    }
    currentUser.allExpenses.allExpenses.insert(0, thisExpense);
    currentUser.recentExpenses = getRecentExpenses(currentUser.allExpenses);
    addToMonthDB(currentUser, thisExpense, theme);
    addToDayDb(currentUser);
    Navigator.of(context).pop();
    BlocProvider.of<UpdateExpenseBloc>(context).add(ExpenseChangedEvent());
  }

  List<barDataMonthly> initializeMonthlyGraphDatabase(
      User currentUser, LightMode theme) {
    List<barDataMonthly> data = [];
    currentUser.monthsDB.allMonths.forEach((key, value) {
      data.add(barDataMonthly(
        month: DateFormat.MMM().format(value.date),
        spent: value.totalSpent.ceil(),
        color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
      ));
    });
    if (data.isEmpty) {
      data.add(barDataMonthly(
        month: DateFormat.MMM().format(DateTime.now()),
        spent: 0,
        color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
      ));
    }
    return data;
  }

  List<barDataDaily> initializeDailyGraphDatabase(
      User currentUser, LightMode theme) {
    List<barDataDaily> data = [];
    currentUser.daysDB.allDays.forEach((key, value) {
      data.add(
        barDataDaily(
          day: key,
          spent: value.amount.ceil(),
          color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
        ),
      );
    });
    if (data.isEmpty) {
      for (int i = 0; i < 10; i++) {
        data.add(
          barDataDaily(
            day: DateTime.now()
                .subtract(Duration(days: i))
                .day
                .toString()
                .padLeft(2, '0'),
            spent: 0,
            color: charts.ColorUtil.fromDartColor(theme.foodNDrinks),
          ),
        );
      }
    }
    return data.reversed.toList();
  }

  List<String> categoryMenu() {
    Categories categories = Categories(theme: LightMode());
    List<String> list = [];
    categories.categories.forEach((key, value) {
      list.add(key);
    });

    return list;
  }

  List<String> analyticsMenu(User currentUser) {
    List<String> list = [];

    currentUser.monthsDB.allMonths.forEach((key, value) {
      list.add(DateFormat('MMMM, y').format(value.date));
    });
    if (list.isEmpty) {
      list.add(DateFormat('MMMM, y').format(DateTime.now()));
    }
    return list;
  }

  List<PieData> generatePieGraphData(Categories categories, LightMode theme) {
    List<PieData> pieData = [];
    categories.categories.forEach((key, value) {
      pieData.add(PieData(
          category: value.name,
          spent: value.amount.ceil(),
          color: value.color));
    });
    return pieData;
  }

  String getTotalAmount(Categories categories) {
    double totalAmount = 0;
    categories.categories.forEach((key, value) {
      totalAmount = totalAmount + value.amount;
    });
    return totalAmount.ceil().toString();
  }

  String getDropDownDefaultValue(RecentExpenses recentExpenses) {
    if (recentExpenses.recentExpenses.isEmpty) {
      print(DateFormat('MMMM, y').format(DateTime.now()));
      return DateFormat('MMMM, y').format(DateTime.now());
    } else {
      if (recentExpenses.recentExpenses[0].date.month == DateTime.now().month &&
          recentExpenses.recentExpenses[0].date.year == DateTime.now().year) {
        return DateFormat('MMMM, y').format(DateTime.now());
      } else {
        return DateFormat('MMMM, y')
            .format(recentExpenses.recentExpenses[0].date);
      }
    }
  }

  double calculateDailyBudget(double monthlyBudget) {
    return monthlyBudget /
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }

  DateTime dateTimeObjectFormat(String date) {
    RegExp regex = RegExp(r'\d+');
    Iterable<Match> matches = regex.allMatches(date);
    List<int> numbers = [];

    for (Match match in matches) {
      numbers.add(int.parse(match.group(0)!));
    }
    return numbers.length == 3
        ? DateTime(numbers[0], numbers[1], numbers[2])
        : DateTime(numbers[0], numbers[1]);
  }

  void tokenLogin(
      Map<String, dynamic> creds, User currentUser, LightMode theme) async {
    ServerAccess sa = ServerAccess();
    final response = await sa.tokenLogin(creds);
    final data = response['data'];
    if (data != null && data['status'] == null) {
      currentUser = User.parse(data, theme);
      currentUser.password = creds['password']!;
    }
  }

  Future<dynamic?> tokenIsExpired(
      String token, User currentUser, LightMode theme) async {
    if (JwtDecoder.isExpired(token)) {
      return null;
    } else {
      Map<String, dynamic> creds = JwtDecoder.decode(token);

      ServerAccess sa = ServerAccess();
      final response = await sa.tokenLogin(creds);
      final data = response['data'];
      if (data != null && data['status'] == null) {
        currentUser = User.parse(data, theme);
        currentUser.password = creds['password']!;
      }
      return currentUser;
    }
  }

  double currentMonthSpent(User currentUser) {
    return currentUser
        .monthsDB.allMonths[monthCommaYear(DateTime.now())]!.totalSpent;
  }

  void categoriesPatch(
      AllExpenses allExpenses, Categories categories, String month) {
    DateTime currentMonth = DateTime(
        int.parse(month.split('-')[0]), int.parse(month.split('-')[1]));
    int p = 0;
    for (var expense in allExpenses.allExpenses) {
      if (expense.date.month == currentMonth.month &&
          expense.date.year == currentMonth.year) {
        p = 1;
        categories.categories[expense.category]!.amount =
            categories.categories[expense.category]!.amount + expense.amount;
      } else if (p == 1) {
        break;
      }
    }
  }
}
