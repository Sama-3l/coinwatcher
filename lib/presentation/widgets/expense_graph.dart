// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/appButton.dart';
import 'package:coinwatcher/presentation/widgets/daily_graph.dart';
import 'package:coinwatcher/presentation/widgets/monthly_graph.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseGraph extends StatefulWidget {
  ExpenseGraph(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});
  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  late Color _colorMonthly = widget.theme.primaryAccent1;
  late Color _colorDaily = widget.theme.mainBackground;
  int index = 0;
  Methods func = Methods();

  late final bgraph = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<BarGraphChangeBloc, BarGraphChangeState>(
      builder: (context, state) {
        return Container(
          // height: 0.25 * height,
          // width: 0.9 * width,
          padding: EdgeInsets.only(top: 16, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.theme.borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //  navigator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //monthly
                  GestureDetector(
                      onTap: () {
                        _colorMonthly = widget.theme.primaryAccent1;
                        _colorDaily = widget.theme.mainBackground;
                        index = 0;
                        BlocProvider.of<BarGraphChangeBloc>(context)
                            .add(ChangeGraphEvent());
                      },
                      child: AppButton(
                        width: width,
                        height: height,
                        color: _colorMonthly,
                        theme: widget.theme,
                        font: widget.font,
                        text: 'monthly',
                      )),

                  //daily

                  GestureDetector(
                      // REPLACE WITH INKWELL
                      onTap: () {
                        setState(() {
                          _colorMonthly = widget.theme.mainBackground;
                          _colorDaily = widget.theme.primaryAccent1;
                          index = 1;
                        });
                      },
                      child: AppButton(
                        width: width,
                        height: height,
                        color: _colorDaily,
                        theme: widget.theme,
                        font: widget.font,
                        text: 'daily',
                      )),
                ],
              ),

              //  Bar Graph
              index == 0
                  ? monthlyGraph(
                    currentUser: widget.currentUser,
                      data: func.initializeMonthlyGraphDatabase(
                          widget.currentUser, widget.theme))
                  : dailyGraph(
                    currentUser: widget.currentUser,
                      data: func.initializeDailyGraphDatabase(
                          widget.currentUser, widget.theme))
            ],
          ),
        );
      },
    );
  }
}
