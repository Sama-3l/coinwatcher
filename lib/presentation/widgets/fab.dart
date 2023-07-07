import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  Fab({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: theme.primaryAccent4,
      child: Text(
        "Add Expenses",
        style: font.getPoppinsTextStyle(
            color: theme.textSecondary,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1),
      ),
    );
  }
}
