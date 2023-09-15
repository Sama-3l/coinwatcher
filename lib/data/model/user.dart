import 'dart:convert';

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

import '../repositories/days.dart';

class User {
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.dailyBudget,
      required this.thisMonthSpent,
      required this.allExpenses,
      required this.recentExpenses,
      required this.monthsDB,
      required this.daysDB});

  String id;
  String name;
  String email;
  String password;
  double dailyBudget;
  double thisMonthSpent; //remove this
  AllExpenses allExpenses;
  RecentExpenses recentExpenses; //DB entry not req
  Months monthsDB;
  Days daysDB;

  factory User.parse(Map<String, dynamic> userInfo, LightMode theme) {
    AllExpenses allExpenses = AllExpenses();
    allExpenses.allExpenses = allExpenses.parse(userInfo['allExpenses']);
    Months monthsDB = Months();
    monthsDB.parse(userInfo['eachMonthDb'], theme, allExpenses);
    Days daysDB = Days();
    Methods func = Methods();
    return User(
        id: userInfo['_id'],
        name: userInfo['name'],
        email: userInfo['email'],
        password: userInfo['password'],
        dailyBudget: double.parse(userInfo['dailyBudget']),
        thisMonthSpent: 0.0,
        allExpenses: allExpenses,
        recentExpenses: func.getRecentExpenses(allExpenses),
        monthsDB: monthsDB,
        daysDB: daysDB);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'dailyBudget': dailyBudget.toString(),
      'allExpenses': allExpenses.toJSON(),
      'eachMonthDb': monthsDB.allMonthsJSON(),
      'eachDayDb': daysDB.allDaysToJSON(),
    };
    return map;
  }
}
