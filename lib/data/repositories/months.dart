import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:flutter/material.dart';

class Months{
  Map<String, Month> allMonths = {};

  List<Map<String, dynamic>> allMonthsJSON() {
    List<Map<String, dynamic>> monthJson = [];
    Methods func = Methods();

    allMonths.forEach((key, value) {
      monthJson.add(value.toJSON());
    });
    return monthJson;
  }
}