import 'package:carbon_icons/carbon_icons.dart';
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
        child: Icon(CarbonIcons.add, size: 30, color: theme.textPrimary));
  }
}
