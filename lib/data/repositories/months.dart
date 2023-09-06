import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:flutter/material.dart';

import 'allExpenses.dart';

class Months {
  Map<String, Month> allMonths = {};

  void parse(List<dynamic> monthsDB, LightMode theme, AllExpenses allExpenses) {
    Methods func = Methods();
    for (var month in monthsDB) {
      double sumCheck = 0.0;
      Categories categories = Categories(theme: theme);
      for (var category in month['categories']) {
        categories.categories[category['name']]!.amount =
            double.parse(category['amount']);
        sumCheck += double.parse(category['amount']);
      }

      allMonths[month['month']] = Month(
          date: func.dateTimeObjectFormat(month['date']),
          totalSpent: double.parse(month['totalSpent']),
          categories: categories);
          
      if (sumCheck != double.parse(month['totalSpent'])) {
        func.categoriesPatch(allExpenses, categories, month['date']);
      }
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
