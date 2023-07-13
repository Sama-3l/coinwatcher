import 'package:coinwatcher/data/model/category.dart';
import 'package:flutter/material.dart';

class Categories {
  List<BrandCategory> categories = [
    BrandCategory(name: 'Food n drinks', amount: 0.0),
    BrandCategory(name: 'Health n Fitness', amount: 0.0),
    BrandCategory(name: 'Personal care', amount: 0.0),
    BrandCategory(name: 'Essentials', amount: 0.0),
    BrandCategory(name: 'Education', amount: 0.0),
    BrandCategory(name: 'Misc', amount: 0.0),
  ];

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> categoriesJSON = {};
    for (int i = 0; i < categories.length; i++) {
      categoriesJSON[categories[i].name] = {
        'name': categories[i].name,
        'amount': categories[i].amount.toString()
      };
    }
    return categoriesJSON;
  }
}
