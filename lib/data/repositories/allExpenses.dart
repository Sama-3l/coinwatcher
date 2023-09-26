import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:flutter/material.dart';

class AllExpenses {
  List<Expense> allExpenses = [
    // Expense(
    //     expenseName: "HnM",
    //     amount: 3000.00,
    //     date: DateTime(2023, 7, 8),
    //     category: "Misc"),
  ];

  List<Expense> parse(List<dynamic> allExpenses) {
    Methods func = Methods();
    List<Expense> expenses = [];
    for (var expense in allExpenses) {
      expenses.add(Expense(
          expenseName: expense['name'],
          amount: double.parse(expense['amount']),
          date: func.dateTimeObjectFormat(expense['date']),
          category: expense['category']));
    }
    return expenses.reversed.toList();
  }

  List<Map<String, dynamic>> toJSON() {
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < allExpenses.length; i++) {
      list.add(allExpenses[i].toJSON());
    }
    return list;
  }
}
