import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/piechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/blocs/changeMonth/change_month_bloc.dart';
import 'legend.dart';

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
    return BlocBuilder<ChangeMonthBloc, ChangeMonthState>(
      builder: (context, state) {
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
                    dropdownValue = value!;
                    BlocProvider.of<ChangeMonthBloc>(context).add(UpdateMonthEvent());
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
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Legend(theme: widget.theme, font: widget.font, categories: widget
                    .currentUser.monthsDB.allMonths[dropdownValue]!.categories),
            )
          ],
        );
      },
    );
  }
}
