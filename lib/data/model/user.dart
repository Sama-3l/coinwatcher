import 'dart:convert';

import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

import '../repositories/days.dart';

class User {
  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.dailyBudget,
      required this.thisMonthSpent,
      required this.allExpenses,
      required this.recentExpenses,
      required this.monthsDB,
      required this.daysDB});

  String name;
  String email;
  String password;
  double dailyBudget;
  double thisMonthSpent;  //remove this
  AllExpenses allExpenses;
  RecentExpenses recentExpenses;  //DB entry not req
  Months monthsDB;
  Days daysDB;

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> map = {
      'name' : name,
      'email' : email,
      'password' : password,
      'dailyBudget': dailyBudget.toString(),
      'thisMonthSpent': thisMonthSpent.toString(),
      'allExpenses': allExpenses.toJSON(),
      'eachMonthDb': monthsDB.allMonthsJSON(),
      'eachDayDb': daysDB.allDaysToJSON(),
    };
    return map;
  }
}
