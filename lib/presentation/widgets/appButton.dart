// ignore_for_file: must_be_immutable

import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.theme,
      required this.font,
      required this.text});

  double width;
  double height;
  Color color;
  LightMode theme;
  FontFamily font;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.24 * width,
      height: 0.03 * height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: font.getPoppinsTextStyle(
            color: theme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
