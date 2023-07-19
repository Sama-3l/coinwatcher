import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/brandCategory.dart';
import 'package:flutter/material.dart';

class LegendItems extends StatelessWidget {
  LegendItems(
      {super.key,
      required this.category,
      required this.theme,
      required this.font});
  BrandCategory category;
  LightMode theme;
  FontFamily font;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 11,
            width: 11,
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.circular(5.5),
            ),
          ),
          Text(
            "Food and drinks",
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
          Text('${category.amount}',
              style: font.getPoppinsTextStyle(
                  color: theme.textPrimary,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0))
        ],
      ),
    );
  }
}
