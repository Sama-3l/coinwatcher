import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/category.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/presentation/widgets/legendItems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Legend extends StatefulWidget {
  Legend(
      {super.key,
      required this.theme,
      required this.font,
      required this.categories});
  LightMode theme;
  FontFamily font;
  Categories categories;

  @override
  State<Legend> createState() => _LegendState();
}

class _LegendState extends State<Legend> {
  WidgetDecider wd = WidgetDecider();
  List<Widget> generateLegendItems() {
    List<Widget> children = [];

    widget.categories.categories.forEach((key, value) {
      children.add(
          LegendItems(category: value, theme: widget.theme, font: widget.font));
    });

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.theme.borderColor),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: generateLegendItems(),
            ),
          )),
    );
  }
}
