// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseBox.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';

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
  String dropDownValue = 'Food n Drinks';

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: allExpenses,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      decoration: BoxDecoration(
                        color: theme.mainBackground,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 21,
                            right: 21,
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: ExpenseInputField(
                                                textEditingController: amount,
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
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: ExpenseInputField(
                                                textEditingController: date,
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
                              padding: EdgeInsets.only(bottom: 18),
                              child: BlocBuilder<DropDownMenuBloc,
                                  DropDownMenuState>(
                                builder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: theme.borderColor,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButton<String>(
                                            value: dropDownValue,
                                            icon: Container(),
                                            onChanged: (String? newValue) {
                                              dropDownValue = newValue!;
                                              BlocProvider.of<DropDownMenuBloc>(
                                                      context)
                                                  .add(UpdateMenuEvent());
                                            },
                                            items: <String>[
                                              'Food n Drinks',
                                              'Health n Fitness',
                                              'Personal care',
                                              'Essentials',
                                              'Education',
                                              'Misc',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    value,
                                                    style: font
                                                        .getPoppinsTextStyle(
                                                            color: theme
                                                                .textPrimary,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing:
                                                                -0.41),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Icon(Icons.arrow_drop_down_sharp,
                                            color: theme.textPrimary)
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.25,
                                  right:
                                      MediaQuery.of(context).size.width * 0.25,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.02),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: theme.primaryAccent4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () {
                                    print(dropDownValue);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      'Add',
                                      style: font.getPoppinsTextStyle(
                                          color: theme.textPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      )),
                ),
              )),
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
