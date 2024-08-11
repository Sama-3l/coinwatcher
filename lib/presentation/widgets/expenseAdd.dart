// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:carbon_icons/carbon_icons.dart';
import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:coinwatcher/services/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/blocs/datePicker/date_picker_bloc.dart';
import '../../business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';

class ExpenseAdd extends StatefulWidget {
  ExpenseAdd({super.key, required this.currentUser, required this.theme, required this.font, this.expense = null, this.edit = false});

  User currentUser;
  LightMode theme;
  FontFamily font;
  bool edit;
  Expense? expense;

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  TextEditingController expenseName = TextEditingController();
  TextEditingController amount = TextEditingController();
  Methods func = Methods();
  WidgetDecider wd = WidgetDecider();
  late List<String> categoryMenu = func.categoryMenu();
  late String dropDownValue = categoryMenu.first;
  DateTime picked = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.expense != null) {
      expenseName.text = widget.expense!.expenseName;
      amount.text = widget.expense!.amount.toString();
      dropDownValue = widget.expense!.category;
      picked = widget.expense!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.currentUser.allExpenses,
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                      color: widget.theme.mainBackground,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 21, top: MediaQuery.of(context).size.height * 0.02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Icon(CupertinoIcons.back, color: widget.theme.textPrimary, size: 30),
                                ),
                                widget.edit ? Spacer() : Container(),
                                widget.edit
                                    ? IconButton(
                                        onPressed: () {
                                          func.deleteExpense(widget.currentUser, widget.expense, context);

                                          ServerAccess sa = ServerAccess();
                                          sa.editExpenseList(widget.currentUser);
                                        },
                                        icon: Icon(CarbonIcons.trash_can, color: widget.theme.error, size: 30))
                                    : Container(),
                              ],
                            ),
                          ),
                          wd.textWidget('Expense Name', widget.font, widget.theme, 18),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ExpenseInputField(textEditingController: expenseName, hintText: 'Shoes', font: widget.font, theme: widget.theme),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    wd.textWidget('Amount', widget.font, widget.theme, 18),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 30),
                                      child: ExpenseInputField(textEditingController: amount, hintText: '1500.00', font: widget.font, currency: true, theme: widget.theme),
                                    ),
                                  ]),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    wd.textWidget('Date', widget.font, widget.theme, 18),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: BlocBuilder<DatePickerBloc, DatePickerState>(
                                          builder: (context, state) {
                                            return TextField(
                                              readOnly: true,
                                              onTap: () async {
                                                picked = (await func.editDate(context, DateTime.now().add(Duration(days: 2)), widget.theme))!;
                                              },
                                              textCapitalization: TextCapitalization.sentences,
                                              style: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: -0.41),
                                              decoration: InputDecoration(
                                                hintStyle: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: -0.41),
                                                hintText: DateFormat('dd MMM, yy').format(picked),
                                                border: InputBorder.none,
                                                fillColor: Colors.transparent,
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
                          wd.textWidget('Category name', widget.font, widget.theme, 18),
                          Padding(
                            padding: EdgeInsets.only(bottom: 18),
                            child: BlocBuilder<DropDownMenuBloc, DropDownMenuState>(
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: widget.theme.borderColor,
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
                                            BlocProvider.of<DropDownMenuBloc>(context).add(UpdateMenuEvent());
                                          },
                                          items: categoryMenu.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  value,
                                                  style: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: -0.41),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down_sharp, color: widget.theme.textPrimary)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25, right: MediaQuery.of(context).size.width * 0.25, bottom: MediaQuery.of(context).size.height * 0.02),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: widget.theme.primaryAccent4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                onPressed: () {
                                  if (widget.edit) {
                                    Expense thisExpense = Expense(expenseName: expenseName.text, amount: double.parse(amount.text), date: picked, category: dropDownValue);

                                    func.updateExpenseFab(widget.expense, widget.currentUser, thisExpense, context, widget.theme);

                                    ServerAccess sa = ServerAccess();
                                    sa.editExpenseList(widget.currentUser);
                                  } else {
                                    Expense thisExpense = Expense(expenseName: expenseName.text, amount: double.parse(amount.text), date: picked, category: dropDownValue);

                                    func.addExpenseFab(widget.currentUser, thisExpense, context, widget.theme);

                                    ServerAccess sa = ServerAccess();
                                    sa.editExpenseList(widget.currentUser);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Text(
                                    'add',
                                    style: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1),
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
