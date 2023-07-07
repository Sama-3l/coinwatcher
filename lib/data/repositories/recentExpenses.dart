import 'package:coinwatcher/data/model/expense.dart';
import 'package:flutter/material.dart';

class RecentExpenses{
  List<Expense> recentExpenses = [
    Expense(expenseName: "HnM", amount: 3000.00, date: DateTime(2023, 7, 8), category: "Clothing"),
    Expense(expenseName: "My Protein", amount: 1500.00, date: DateTime(2023, 7, 7), category: "Health n Fitness"),
  ];
}