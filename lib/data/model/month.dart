import 'dart:convert';

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:flutter/material.dart';

class Month{
  Month({required this.date, required this.totalSpent, required this.categories});

  DateTime date; 
  double totalSpent;
  Categories categories;
  Methods func = Methods();

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> month = {
      "month" : func.monthCommaYear(date),
      "date": '${date.year}-${date.month}',
      "totalSpent": totalSpent.toString(),
      "categories" : categories.toJSON()
    };
    return month;
  }
}