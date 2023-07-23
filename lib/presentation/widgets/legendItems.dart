import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/category.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 11,
          width: 11,
          decoration: BoxDecoration(
            color: category.color,
            borderRadius: BorderRadius.circular(5.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 9.5),
          child: Text(
            category.name,
            style: font.getPoppinsTextStyle(
                color: theme.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('\u{20B9}${category.amount}',
                style: font.getPoppinsTextStyle(
                    color: theme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0)),
          ),
        )
      ],
    );
  }
}
