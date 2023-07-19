import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/brandCategory.dart';
import 'package:coinwatcher/presentation/widgets/legendItems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Legend extends StatefulWidget {
  Legend({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;
  late Map<String, BrandCategory> categories = {
    'Food n drinks': BrandCategory(
        color: theme.foodNDrinks, name: 'Food n drinks', amount: 0.0),
    'Health n Fitness':
        BrandCategory(color: theme.hnF, name: 'Health n Fitness', amount: 0.0),
    'Personal care': BrandCategory(
        color: theme.personalCare, name: 'Personal care', amount: 0.0),
    'Essentials':
        BrandCategory(color: theme.essentials, name: 'Essentials', amount: 0.0),
    'Education':
        BrandCategory(color: theme.education, name: 'Education', amount: 0.0),
    'Misc': BrandCategory(color: theme.misc, name: 'Misc', amount: 0.0),
  };

  @override
  State<Legend> createState() => _LegendState();
}

class _LegendState extends State<Legend> {
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: 0.25 * height,
        width: 0.9 * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: widget.theme.borderColor),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              widget.categories.forEach((key, value) {
                LegendItems(
                    category: value, theme: widget.theme, font: widget.font);
              })
            ],
          ),
        ));
  }
}
