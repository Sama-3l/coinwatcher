import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

class User {
  User(
      {required this.name,
      required this.dailyBudget,
      required this.thisMonthSpent,
      required this.allExpenses,
      required this.recentExpenses,
      required this.monthsDB,
      required this.eachDaySpent});

  String name;
  double dailyBudget;
  double thisMonthSpent;
  AllExpenses allExpenses;
  RecentExpenses recentExpenses;
  Months monthsDB;
  Map<String, double> eachDaySpent;

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> map = {
      'name' : name,
      'dailyBudget': dailyBudget.toString(),
      'thisMonthSpent': thisMonthSpent.toString(),
      'allExpenses': allExpenses.toJSON(),
      'eachMonthDb': monthsDB.allMonthsJSON(),
      'eachDaySpent': eachDaySpent
    };
    return map;
  }
}
