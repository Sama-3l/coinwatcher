import 'package:coinwatcher/data/model/month.dart';
import 'package:flutter/material.dart';

class Months{
  List<Month> allMonths = [];

  Map<String, dynamic> allMonthsJSON() {
    Map<String, dynamic> monthJson = {};
    for(int i = 0; i < allMonths.length; i++){
      monthJson["${allMonths[i].date.month},${allMonths[i].date.year}"] = allMonths[i].toJSON();
    }
    return monthJson;
  }
}