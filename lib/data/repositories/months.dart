import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:flutter/material.dart';

class Months{
  Map<String, Month> allMonths = {};

  Map<String, dynamic> allMonthsJSON() {
    Map<String, dynamic> monthJson = {};
    Methods func = Methods();

    allMonths.forEach((key, value) {
      monthJson[key] = {
        func.monthCommaYear(value.date) : value.toJSON()
      };
    });
    return monthJson;
  }
}