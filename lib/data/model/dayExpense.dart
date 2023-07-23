import 'package:flutter/material.dart';

class DayExpense{
  DayExpense({required this.date, required this.amount});

  DateTime date;
  double amount;

  Map<String, String> toJSON(){
    return {
      'date' : date.toString(),
      'amount': amount.toString()
    };
  }
}