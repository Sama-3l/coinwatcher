import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:flutter/material.dart';

class Months {
  Map<String, Month> allMonths = {};

  void parse(List<dynamic> monthsDB, LightMode theme) {
    Methods func = Methods();
    for (var month in monthsDB) {
      Categories categories = Categories(theme: theme);

      allMonths[month['month']] = Month(
          date: func.dateTimeObjectFormat(month['date']),
          totalSpent: double.parse(month['totalSpent']),
          categories: categories);
    }
  }

  List<Map<String, dynamic>> allMonthsJSON() {
    List<Map<String, dynamic>> monthJson = [];
    Methods func = Methods();

    allMonths.forEach((key, value) {
      monthJson.add(value.toJSON());
    });
    return monthJson;
  }
}
