// ignore_for_file: unused_local_variable

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