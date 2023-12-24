import "package:coinwatcher/constants/themes.dart";
import 'package:coinwatcher/data/model/category.dart';

class Categories {

  LightMode theme;

  late Map<String, BrandCategory> categories = {
    "Food n drinks": BrandCategory(name: "Food n drinks", amount: 0.0, color: theme.foodNDrinks),
    "Health n Fitness": BrandCategory(name: "Health n Fitness", amount: 0.0, color: theme.hnF),
    "Personal care": BrandCategory(name: "Personal care", amount: 0.0, color: theme.personalCare),
    "Essentials": BrandCategory(name: "Essentials", amount: 0.0, color: theme.essentials),
    "Education": BrandCategory(name: "Education", amount: 0.0, color: theme.education),
    "Misc": BrandCategory(name: "Misc", amount: 0.0, color: theme.misc),
  };

  List<Map<String, dynamic>> toJSON() {
    List<Map<String, dynamic>> categoriesJSON = [];
    
    categories.forEach((key, value) {
      categoriesJSON.add({
        "name": value.name,
        "amount": value.amount.toString()
      });
    });
    return categoriesJSON;
  }

  void parse(List<dynamic> categories){
    for(var category in categories){
      this.categories[category['name']]!.amount = category['amount'];
    }
  }

  Categories({required this.theme});
}
