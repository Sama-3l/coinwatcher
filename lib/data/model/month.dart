import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:flutter/material.dart';

class Month{
  Month({required this.date, required this.totalSpent, required this.categories});

  DateTime date; 
  double totalSpent;
  Categories categories;

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> month = {
      'month' : "${date.month}, ${date.year}",
      'totalSpent': totalSpent,
      'categories' : categories.toJSON()
    };
    return month;
  }
}