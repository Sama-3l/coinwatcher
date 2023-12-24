// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expenseInputField.dart';

class ChangeBudget extends StatefulWidget {
  ChangeBudget(
      {super.key,
      required this.currentUser,
      required this.theme,
      required this.font});

  User currentUser;
  LightMode theme;
  FontFamily font;

  @override
  State<ChangeBudget> createState() => _ChangeBudgetState();
}

class _ChangeBudgetState extends State<ChangeBudget> {
  WidgetDecider wd = WidgetDecider();
  Methods func = Methods();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.currentUser,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                  alignment: Alignment.center,
                  child: Container(
                      decoration: BoxDecoration(
                        color: widget.theme.mainBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 17, right: 17, top: 24),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: wd.textWidget('Monthly Budget',
                                  widget.font, widget.theme, 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 21),
                              child: ExpenseInputField(
                                  textEditingController: controller,
                                  currency: true,
                                  hintText:
                                      '${func.monthlyBudget(widget.currentUser.dailyBudget)}',
                                  font: widget.font,
                                  theme: widget.theme,
                                  fontSize: 24),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          widget.theme.primaryAccent4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {
                                    widget.currentUser.dailyBudget =
                                        func.calculateDailyBudget(
                                            double.parse(controller.text));
                                    ServerAccess sa = ServerAccess();
                                    sa.updateDailyBudget(widget.currentUser);
                                    BlocProvider.of<UpdateExpenseBloc>(context)
                                        .add(ExpenseChangedEvent());
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                      'Add',
                                      style: widget.font.getPoppinsTextStyle(
                                          color: widget.theme.textPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            )
                          ]))))),
        ),
      ),
    );
  }
}
