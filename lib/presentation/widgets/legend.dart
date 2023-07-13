import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class Legend extends StatefulWidget {
  Legend({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

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
              const EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.foodNDrinks,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.hnF,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.personalCare,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.essentials,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.education,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                  Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: widget.theme.misc,
                      borderRadius: BorderRadius.circular(5.5),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Food and drinks",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Health n Fitness",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Personal care",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Essentials",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Education",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                    Text(
                      "Misc",
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                  wd.showLegendAmounts(2500.00, widget.font, widget.theme),
                ],
              )
            ],
          ),
        ));
  }
}
