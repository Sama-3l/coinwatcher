// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alogrithms/method.dart';
import '../../data/model/user.dart';
import '../../data/repositories/allExpenses.dart';
import '../../data/repositories/days.dart';
import '../../data/repositories/months.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isValid = false;
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
                    hintText: "Username",
                    theme: theme,
                    font: font),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ExpenseInputField(
                    textEditingController: email,
                    hintText: "Email address",
                    theme: theme,
                    font: font),
              ),
              BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
                builder: (context, state) {
                  return PasswordTextField(
                    onPasswordValidityChanged: (isValid) {
                      this.isValid = isValid;
                    },
                    password: password,
                  );
                },
              ),
              Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 24, left: 48, right: 48),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.primaryAccent2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    )),
                                onPressed: () {
                                  print(username.text);
                                  print(email.text);
                                  if (isValid) {
                                    AllExpenses allExpenses = AllExpenses();
                                    Methods func = Methods();
                                    Months month = Months();
                                    Days days = Days();
                                    User currentUser = User(
                                        name: username.text,
                                        email: email.text,
                                        password: password.text,
                                        dailyBudget: 250,
                                        thisMonthSpent: 0.0,
                                        allExpenses: allExpenses,
                                        recentExpenses:
                                            func.getRecentExpenses(allExpenses),
                                        monthsDB: month,
                                        daysDB: days);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Home(
                                          font: font,
                                          theme: theme,
                                          currentUser: currentUser);
                                    }));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Text(
                                    "SIGN UP",
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
                        Text("ALREADY HAVE AN ACCOUNT?",
                            style: font.getPoppinsTextStyle(
                                color: theme.borderColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }));
                            },
                            child: Text(
                              "LOG IN",
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
            ],
          ),
        ),
      ),
    );
  }
}
