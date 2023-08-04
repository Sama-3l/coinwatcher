import 'package:coinwatcher/data/model/expense.dart';
import 'package:flutter/material.dart';

class AllExpenses {
  List<Expense> allExpenses = [
    // Expense(
    //     expenseName: "HnM",
    //     amount: 3000.00,
    //     date: DateTime(2023, 7, 8),
    //     category: "Misc"),
    // Expense(
    //     expenseName: "My Protein",
    //     amount: 1500.00,
    //     date: DateTime(2023, 7, 7),
    //     category: "Health n Fitness"),
    // Expense(
    //     expenseName: "Udemy",
    //     amount: 700.00,
    //     date: DateTime(2023, 6, 25),
    //     category: "Education"),
    // Expense(
    //     expenseName: "Veg puff",
    //     amount: 15.00,
    //     date: DateTime(2023, 6, 23),
    //     category: "Food n drinks"),
    // Expense(
    //     expenseName: "Dominoes",
    //     amount: 1000.00,
    //     date: DateTime(2023, 6, 23),
    //     category: "Food n drinks"),
    // Expense(
    //     expenseName: "Jio",
    //     amount: 450.00,
    //     date: DateTime(2023, 6, 21),
    //     category: "Essentials"),
    // Expense(
    //     expenseName: "Facewash",
    //     amount: 500.00,
    //     date: DateTime(2023, 6, 21),
    //     category: "Personal care"),
    // Expense(
    //     expenseName: "Burger King",
    //     amount: 200.00,
    //     date: DateTime(2023, 6, 20),
    //     category: "Food n drinks"),
  ];

  List<Map<String, dynamic>> toJSON(){
    List<Map<String, dynamic>> list = [];
    for(int i = 0; i < allExpenses.length; i++){
      list.add(allExpenses[i].toJSON());
    }
    return list;
  }
}
