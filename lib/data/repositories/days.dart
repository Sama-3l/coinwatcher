import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/dayExpense.dart';

class Days{
  Map<String, DayExpense> allDays = {};

  Map<String, dynamic> allDaysToJSON(){
    Map<String, dynamic> json = {};
    int p = 0;

    allDays.forEach((key, value) { 
      json["day-$p"] = value.toJSON();
      p++;
    });

    return json;
  }
}