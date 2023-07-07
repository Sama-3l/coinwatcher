import 'package:flutter/material.dart';

class Expense {
  Expense(
      {required this.expenseName,
      required this.amount,
      required this.date,
      required this.category});

  String expenseName;
  double amount;
  DateTime date;
  String category;
}
