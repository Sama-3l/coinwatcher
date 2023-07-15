import 'package:coinwatcher/data/model/category.dart';
import 'package:flutter/material.dart';

class Categories {
  Map<String, BrandCategory> categories = {
    'Food n drinks': BrandCategory(name: 'Food n drinks', amount: 0.0),
    'Health n Fitness': BrandCategory(name: 'Health n Fitness', amount: 0.0),
    'Personal care': BrandCategory(name: 'Personal care', amount: 0.0),
    'Essentials': BrandCategory(name: 'Essentials', amount: 0.0),
    'Education': BrandCategory(name: 'Education', amount: 0.0),
    'Misc': BrandCategory(name: 'Misc', amount: 0.0),
  };

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> categoriesJSON = {};
    categories.forEach((key, value) {
      categoriesJSON[key] = {
        'name': value.name,
        'amount': value.amount.toString()
      };
    });
    return categoriesJSON;
  }
}
