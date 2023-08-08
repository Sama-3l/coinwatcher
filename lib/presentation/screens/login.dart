// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/days.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/register.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  LightMode theme = LightMode();
  FontFamily font = FontFamily();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.mainBackground,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ExpenseInputField(
                    textEditingController: username,
                    hintText: "Username or Email address",
                    theme: theme,
                    font: font),
              ),
              BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ExpenseInputField(
                        passwordIcon: true,
                        textEditingController: password,
                        hintText: "Password",
                        theme: theme,
                        font: font),
                  );
                },
              ),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24, left: 48, right: 48),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryAccent2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                            onPressed: () {
                              AllExpenses allExpenses = AllExpenses();
                              Methods func = Methods();
                              Months month = Months();
                              Days days = Days();
                              User currentUser = User(
                                  name: 'Samael',
                                  email: username.text,
                                  password: password.text,
                                  dailyBudget: 250,
                                  thisMonthSpent: 0.0,
                                  allExpenses: allExpenses,
                                  recentExpenses:
                                      func.getRecentExpenses(allExpenses),
                                  monthsDB: month,
                                  daysDB: days);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Home(font: font, theme: theme, currentUser: currentUser);
                              }));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "LOG IN",
                                style: font.getPoppinsTextStyle(
                                    color: theme.textPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("DON'T HAVE AN ACCOUNT?",
                        style: font.getPoppinsTextStyle(
                            color: theme.borderColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return RegistrationPage();
                          }));
                        },
                        child: Text(
                          "SIGN UP",
                          style: font.getPoppinsTextStyle(
                              color: theme.primaryAccent3,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
