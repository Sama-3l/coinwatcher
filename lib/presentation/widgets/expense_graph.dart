import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/appButton.dart';
import 'package:coinwatcher/presentation/widgets/daily_graph.dart';
import 'package:coinwatcher/presentation/widgets/monthly_graph.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseGraph extends StatefulWidget {
  const ExpenseGraph({
    super.key,
    required this.theme,
    required this.font,
    required this.currentUser,
  });

  final LightMode theme;
  final FontFamily font;
  final User currentUser;

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  late Color _colorMonthly = widget.theme.primaryAccent1;
  late Color _colorDaily = widget.theme.mainBackground;
  int index = 0;
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<BarGraphChangeBloc, BarGraphChangeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: widget.theme.borderColor),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Navigator buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Monthly
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _colorMonthly = widget.theme.primaryAccent1;
                        _colorDaily = widget.theme.mainBackground;
                        index = 0;
                      });
                      context.read<BarGraphChangeBloc>().add(ChangeGraphEvent());
                    },
                    child: AppButton(
                      width: width,
                      height: height,
                      color: _colorMonthly,
                      theme: widget.theme,
                      font: widget.font,
                      text: 'monthly',
                    ),
                  ),
                  // Daily
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _colorMonthly = widget.theme.mainBackground;
                        _colorDaily = widget.theme.primaryAccent1;
                        index = 1;
                      });
                      context.read<BarGraphChangeBloc>().add(ChangeGraphEvent());
                    },
                    child: AppButton(
                      width: width,
                      height: height,
                      color: _colorDaily,
                      theme: widget.theme,
                      font: widget.font,
                      text: 'daily',
                    ),
                  ),
                ],
              ),

              // Graph
              const SizedBox(height: 12),
              index == 0
                  ? MonthlyGraphFL(
                      currentUser: widget.currentUser,
                      data: func.initializeMonthlyGraphDatabase(widget.currentUser, widget.theme),
                    )
                  : DailyGraphFL(
                      currentUser: widget.currentUser,
                      data: func.initializeDailyGraphDatabase(widget.currentUser, widget.theme),
                    ),
            ],
          ),
        );
      },
    );
  }
}
