import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:flutter/material.dart';

class Spendings extends StatefulWidget {
  Spendings({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  State<Spendings> createState() => _SpendingsState();
}

class _SpendingsState extends State<Spendings> {
  AllExpenses allExpenses = AllExpenses();
  RecentExpenses recentExpenses = RecentExpenses();
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 21, right: 21),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: wd.getSpendingsWidgets(
                allExpenses, recentExpenses, widget.theme, widget.font)),
      )),
      // body: ListView.builder(
      //     itemCount: allExpenses.allExpenses.length,
      //     itemBuilder: (context, index) {
      //       Column(
      //         children: [Container(color: Colors.black, height: 20, width: 50,)],
      //       );
      //       // wd.getSpendingsWidgets(
      //       //     allExpenses, recentExpenses, index, widget.theme, widget.font);
      //     }),
    );
  }
}
