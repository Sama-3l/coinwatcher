import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/piechart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PieChartMenu extends StatefulWidget {
  PieChartMenu(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});
  FontFamily font;
  LightMode theme;
  User currentUser;

  @override
  State<PieChartMenu> createState() => _PieChartMenuState();
}

class _PieChartMenuState extends State<PieChartMenu> {
  Methods func = Methods();
  late List<String> list = func.analyticsMenu(widget.currentUser);
  late String dropdownValue = DateFormat('MMMM, y').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              underline: Container(),
              icon: Icon(Icons.arrow_drop_down_sharp,
                  color: widget.theme.borderColor),
              elevation: 16,
              style: widget.font.getPoppinsTextStyle(
                  color: widget.theme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        PieChart(
            theme: widget.theme,
            font: widget.font,
            currentMonthCategories: widget
                .currentUser.monthsDB.allMonths[dropdownValue]!.categories),
      ],
    );
  }
}
