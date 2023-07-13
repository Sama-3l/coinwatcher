import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/widgets/expense_graph.dart';
import 'package:coinwatcher/presentation/widgets/legend.dart';
import 'package:coinwatcher/presentation/widgets/piechart.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 21, right: 21, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Analytics",
              style: widget.font.getPoppinsTextStyle(
                color: widget.theme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ExpenseGraph(
              theme: widget.theme,
              font: widget.font,
            ),
            PieChart(
              theme: widget.theme,
              font: widget.font,
            ),

            // Legend
            Legend(theme: widget.theme, font: widget.font)
          ],
        ),
      ),
    );
  }
}
