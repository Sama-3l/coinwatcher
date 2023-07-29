import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/dayExpense.dart';

class Days{
  Map<String, DayExpense> allDays = {};

  List<Map<String, dynamic>> allDaysToJSON(){
    List<Map<String, dynamic>> json = [];
    int p = 0;

    allDays.forEach((key, value) { 
      json.add(value.toJSON());
      p++;
    });

    return json;
  }
}