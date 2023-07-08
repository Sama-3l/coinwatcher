import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/data/model/expense.dart';

class ExpenseBox extends StatefulWidget {
  ExpenseBox(
      {super.key,
      required this.currentExpense,
      required this.theme,
      required this.font});

  Expense currentExpense;
  LightMode theme;
  FontFamily font;

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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: widget.theme.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
          child: Row(children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Color(0xffd9d9d9),
                  borderRadius: BorderRadius.circular(4)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.currentExpense.expenseName,
                        style: widget.font.getPoppinsTextStyle(
                            color: widget.theme.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.41)),
                    Row(
                      children: [
                        Text(widget.currentExpense.category,
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.41)),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            height: 4,
                            width: 4,
                            decoration: BoxDecoration(
                                color: widget.theme.textSecondary,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        Text(
                            func.getMonthandYear(
                                date: widget.currentExpense.date,
                                commaReq: false),
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.41)),
                      ],
                    )
                  ]),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: wd.showAmount(
                        widget.currentExpense, widget.font, widget.theme)))
          ]),
        ),
      ),
    );
  }
}
