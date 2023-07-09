import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/widgets/expense_graph.dart';

import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  Analytics({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: expenseGraph(
        theme: widget.theme,
        font: widget.font,
      ),
    );
  }
}
