// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:flutter/material.dart';

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
                          padding: EdgeInsets.only(
                              left: 17,
                              right: 17,
                              top: 24),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: wd.textWidget(
                                  'Monthly Budget', widget.font, widget.theme, 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 21),
                              child: ExpenseInputField(
                                  textEditingController: controller,
                                  hintText: '\u20B9${func.monthlyBudget(widget.currentUser.dailyBudget)}',
                                  font: widget.font,
                                  theme: widget.theme,
                                  fontSize: 24),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: widget.theme.primaryAccent4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50))),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 10, bottom: 10),
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