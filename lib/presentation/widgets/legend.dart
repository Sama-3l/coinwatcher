import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class legend extends StatefulWidget {
  legend({super.key, required this.theme, required this.font});
  LightMode theme;
  FontFamily font;

  @override
  State<legend> createState() => _legendState();
}

class _legendState extends State<legend> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: 0.19 * height,
        width: 0.9 * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: widget.theme.borderColor),
        ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "foodnDrinks",
                  style: widget.font.getPoppinsTextStyle(
                      color: widget.theme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
                Text(
                  "HnF",
                  style: widget.font.getPoppinsTextStyle(
                      color: widget.theme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
                Text(
                  "Personalcare",
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
                  "education",
                  style: widget.font.getPoppinsTextStyle(
                      color: widget.theme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
                Text(
                  "misc",
                  style: widget.font.getPoppinsTextStyle(
                      color: widget.theme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
              ],
            ),
            SizedBox(
              width: 70,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('\u{20B9}${2500}'),
                Text('\u{20B9}${2500}'),
                Text('\u{20B9}${2500}'),
                Text('\u{20B9}${2500}'),
                Text('\u{20B9}${2500}'),
                Text('\u{20B9}${2500}'),
              ],
            )
          ],
        ));
  }
}
