import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/assets/svgs.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/widgets/expenseAdd.dart';
import 'package:coinwatcher/routes/popUpAnimateRoute.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class ExpenseBox extends StatefulWidget {
  ExpenseBox({super.key, required this.currentUser, required this.currentExpense, required this.theme, required this.font, this.forDashboard = false});

  User currentUser;
  Expense currentExpense;
  LightMode theme;
  FontFamily font;
  bool forDashboard;

  @override
  State<ExpenseBox> createState() => _ExpenseBoxState();
}

class _ExpenseBoxState extends State<ExpenseBox> {
  Methods func = Methods();
  WidgetDecider wd = WidgetDecider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) => Align(alignment: Alignment.bottomCenter, child: ExpenseAdd(edit: true, expense: widget.currentExpense, currentUser: widget.currentUser, theme: widget.theme, font: widget.font))));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: widget.theme.borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
            child: Row(children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Color(0xffd9d9d9), borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Iconify(
                    svgs[widget.currentExpense.category]!,
                    color: widget.theme.textSecondary,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.currentExpense.expenseName, style: widget.font.getPoppinsTextStyle(color: widget.theme.textPrimary, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.41)),
                    Row(
                      children: [
                        Text(widget.currentExpense.category, style: widget.font.getPoppinsTextStyle(color: widget.theme.textSecondary, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: -0.41)),
                        widget.forDashboard
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  height: 3,
                                  width: 3,
                                  decoration: BoxDecoration(color: widget.theme.textSecondary, borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                        widget.forDashboard ? Container() : Text(func.getMonthandYear(date: widget.currentExpense.date, commaReq: false), style: widget.font.getPoppinsTextStyle(color: widget.theme.textSecondary, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: -0.41)),
                      ],
                    )
                  ]),
                ),
              ),
              Center(child: wd.showAmount(widget.currentExpense, widget.font, widget.theme))
            ]),
          ),
        ),
      ),
    );
  }
}
