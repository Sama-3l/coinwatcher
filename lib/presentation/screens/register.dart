// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/crypt.dart';
import 'package:coinwatcher/business_logic/blocs/bloc/loading_bloc.dart';
import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:coinwatcher/services/server.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../alogrithms/method.dart';
import '../../data/model/user.dart';
import '../../data/repositories/allExpenses.dart';
import '../../data/repositories/days.dart';
import '../../data/repositories/months.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage(
      {required this.theme, required this.font, required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isValid = false;
  late SharedPreferences prefs;
  bool loading = false;

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
    return SafeArea(
      child: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          if (!loading) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: widget.theme.mainBackground,
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
                          theme: widget.theme,
                          font: widget.font),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ExpenseInputField(
                          textEditingController: email,
                          hintText: "Email address",
                          theme: widget.theme,
                          font: widget.font),
                    ),
                    BlocBuilder<PasswordVisibilityBloc,
                        PasswordVisibilityState>(
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
                                  padding: EdgeInsets.only(
                                      top: 24, left: 48, right: 48),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              widget.theme.primaryAccent2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                          )),
                                      onPressed: () async {
                                        if (isValid) {
                                          AllExpenses allExpenses =
                                              AllExpenses();
                                          Methods func = Methods();
                                          Months month = Months();
                                          Days days = Days();
                                          Crypt crypt = Crypt();
                                          widget.currentUser = User(
                                              id: "",
                                              name: username.text,
                                              email: email.text,
                                              password: crypt.encodeToSha256(
                                                  password.text),
                                              dailyBudget: 250,
                                              thisMonthSpent: 0.0,
                                              allExpenses: allExpenses,
                                              recentExpenses:
                                                  func.getRecentExpenses(
                                                      allExpenses),
                                              monthsDB: month,
                                              daysDB: days);
                                          username.clear();
                                          email.clear();
                                          password.clear();
                                          ServerAccess sa = ServerAccess();
                                          bool success = false;
                                          loading = true;
                                          BlocProvider.of<LoadingBloc>(context)
                                              .add(LoadingNowEvent());
                                          var serverResponse =
                                              await sa.register(
                                                  widget.currentUser, prefs);
                                          loading = false;
                                          password = TextEditingController();
                                          BlocProvider.of<LoadingBloc>(context)
                                              .add(LoadingNowEvent());
                                          success = serverResponse['success'];
                                          if (success == true) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                              return Home(
                                                  font: widget.font,
                                                  theme: widget.theme,
                                                  currentUser:
                                                      widget.currentUser);
                                            }));
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: Text(
                                          "SIGN UP",
                                          style: widget.font
                                              .getPoppinsTextStyle(
                                                  color:
                                                      widget.theme.textPrimary,
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
                                  style: widget.font.getPoppinsTextStyle(
                                      color: widget.theme.borderColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginPage(
                                          theme: widget.theme,
                                          font: widget.font,
                                          currentUser: widget.currentUser);
                                    }));
                                  },
                                  child: Text(
                                    "LOG IN",
                                    style: widget.font.getPoppinsTextStyle(
                                        color: widget.theme.primaryAccent3,
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
            );
          } else {
            return Scaffold(
                backgroundColor: widget.theme.mainBackground,
                body: Center(
                    child: CircularProgressIndicator(
                        color: widget.theme.textPrimary)));
          }
        },
      ),
    );
  }
}
