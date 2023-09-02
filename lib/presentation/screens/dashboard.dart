// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:coinwatcher/presentation/widgets/expense_graph.dart';
import 'package:coinwatcher/presentation/widgets/spendingsTracker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constant.dart';
import '../../data/repositories/days.dart';
import '../../data/repositories/months.dart';

class Dashboard extends StatefulWidget {
  Dashboard(
      {super.key,
      required this.theme,
      required this.font,
      required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Methods func = Methods();
  WidgetDecider wd = WidgetDecider();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 21, right: 21),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var signOut = await wd.showSignOutDialog(
                          context, prefs, widget.font, widget.theme);
                      print(signOut);
                      if (signOut) {
                        User currentUser = User(
                            id: "",
                            name: "",
                            email: "",
                            password: "",
                            dailyBudget: 250.0,
                            thisMonthSpent: 0.0,
                            allExpenses: AllExpenses(),
                            recentExpenses:
                                func.getRecentExpenses(AllExpenses()),
                            monthsDB: Months(),
                            daysDB: Days());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage(
                                theme: widget.theme,
                                font: widget.font,
                                currentUser: currentUser)));
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Text(
                            "Hi,",
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textPrimary,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.41),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "${widget.currentUser.name}!",
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textPrimary,
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.41),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      func.getMonthandYear(date: DateTime.now()),
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: SpendingsTracker(
                      theme: widget.theme,
                      font: widget.font,
                      currentUser: widget.currentUser,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Analytics',
                      style: widget.font.getPoppinsTextStyle(
                          color: widget.theme.textSecondary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: ExpenseGraph(
                          theme: widget.theme,
                          font: widget.font,
                          currentUser: widget.currentUser)),
                  //Analytics
                  //View more button -> Diverts to the analytics tab
                  widget.currentUser.recentExpenses.recentExpenses.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Recent spendings',
                            style: widget.font.getPoppinsTextStyle(
                                color: widget.theme.textSecondary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Container()),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: wd.getRecentSpendings(
                          widget.currentUser.recentExpenses,
                          widget.theme,
                          widget.font)),
                  SizedBox(height: pagePadding)
                ]),
          ),
        ),
      ),
    );
  }
}
