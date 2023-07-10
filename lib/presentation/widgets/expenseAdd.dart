// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseBox.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';

class ExpenseAdd extends StatelessWidget {
  ExpenseAdd(
      {super.key,
      required this.allExpenses,
      required this.theme,
      required this.font});

  AllExpenses allExpenses;
  LightMode theme;
  FontFamily font;
  TextEditingController expenseName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: allExpenses,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: theme.mainBackground,
              child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 21,
                        right: 21,
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget('Expense Name'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ExpenseInputField(
                                textEditingController: expenseName,
                                hintText: 'Shoes',
                                font: font,
                                theme: theme),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWidget('Amount'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 30),
                                          child: ExpenseInputField(
                                              textEditingController:
                                                  amount,
                                              hintText: '\u20B91500.00',
                                              font: font,
                                              theme: theme),
                                        ),
                                      ]),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textWidget('Date'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 30),
                                          child: ExpenseInputField(
                                              textEditingController:
                                                  date,
                                              hintText: '23 June, 2023',
                                              font: font,
                                              theme: theme),
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          ),
                          textWidget('Category name'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: ExpenseInputField(
                                textEditingController: category,
                                hintText: 'Clothing',
                                font: font,
                                theme: theme),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05),
                            child: ElevatedButton(
                                onPressed: () {}, child: Text('Hello')),
                          )
                        ],
                      ),
                    ),
                  ))),
        ));
  }

  Padding textWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, bottom: 7),
      child: Text(
        text,
        style: font.getPoppinsTextStyle(
            color: theme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41),
      ),
    );
  }
}
