// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseBox.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:coinwatcher/services/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/blocs/datePicker/date_picker_bloc.dart';
import '../../business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';

class ExpenseAdd extends StatelessWidget {
  ExpenseAdd(
      {super.key,
      required this.currentUser,
      required this.theme,
      required this.font});

  User currentUser;
  LightMode theme;
  FontFamily font;
  TextEditingController expenseName = TextEditingController();
  TextEditingController amount = TextEditingController();
  Methods func = Methods();
  WidgetDecider wd = WidgetDecider();
  late List<String> categoryMenu = func.categoryMenu();
  late String dropDownValue = categoryMenu.first;
  DateTime picked =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: currentUser.allExpenses,
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
                          wd.textWidget('Expense Name', font, theme, 18),
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
                                        wd.textWidget('Amount', font, theme, 18),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30),
                                          child: ExpenseInputField(
                                              textEditingController: amount,
                                              hintText: '1500.00',
                                              font: font,
                                              currency: true,
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
                                        wd.textWidget('Date', font, theme, 18),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 30),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: BlocBuilder<DatePickerBloc,
                                                DatePickerState>(
                                              builder: (context, state) {
                                                return TextField(
                                                  readOnly: true,
                                                  onTap: () async {
                                                    picked =
                                                        (await func.editDate(
                                                            context,
                                                            DateTime.now()
                                                                .add(Duration(
                                                                    days: 2)),
                                                            theme))!;
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  style: font
                                                      .getPoppinsTextStyle(
                                                          color: theme
                                                              .textPrimary,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing:
                                                              -0.41),
                                                  decoration: InputDecoration(
                                                    hintStyle: font
                                                        .getPoppinsTextStyle(
                                                            color: theme
                                                                .textPrimary,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            letterSpacing:
                                                                -0.41),
                                                    hintText: DateFormat(
                                                            'dd MMM, yy')
                                                        .format(picked),
                                                    border: InputBorder.none,
                                                    fillColor:
                                                        Colors.transparent,
                                                    filled: true,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          ),
                          wd.textWidget('Category name', font, theme, 18),
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButton<String>(
                                          value: dropDownValue,
                                          icon: Container(),
                                          underline: Container(),
                                          onChanged: (String? newValue) {
                                            dropDownValue = newValue!;
                                            BlocProvider.of<DropDownMenuBloc>(
                                                    context)
                                                .add(UpdateMenuEvent());
                                          },
                                          items: categoryMenu
                                              .map<DropdownMenuItem<String>>(
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
                                  Expense thisExpense = Expense(
                                      expenseName: expenseName.text,
                                      amount: double.parse(amount.text),
                                      date: picked,
                                      category: dropDownValue);

                                  func.addExpenseFab(
                                      currentUser, thisExpense, context, theme);

                                  // ServerAccess sa = ServerAccess();
                                  // sa.fetchDataFromServer(currentUser);
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
            )));
  }
}
