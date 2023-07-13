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
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
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
          expenseGraph(
            theme: widget.theme,
            font: widget.font,
          ),
          PieChart(
            theme: widget.theme,
            font: widget.font,
          ),

          // Legend
          legend(theme: widget.theme, font: widget.font)
        ],
      ),
    );
  }
}
