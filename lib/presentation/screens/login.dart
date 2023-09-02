// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/crypt.dart';
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
import 'package:coinwatcher/services/server.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage(
      {required this.theme, required this.font, required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
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
                    textEditingController: email,
                    hintText: "Email address",
                    theme: widget.theme,
                    font: widget.font),
              ),
              BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ExpenseInputField(
                        passwordIcon: true,
                        textEditingController: password,
                        hintText: "Password",
                        theme: widget.theme,
                        font: widget.font),
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
                                backgroundColor: widget.theme.primaryAccent2,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                )),
                            onPressed: () async {
                              Crypt crypt = Crypt();
                              var cred = {
                                "email": email.text,
                                "password": crypt.encodeToSha256(password.text)
                              };
                              ServerAccess sa = ServerAccess();
                              final response = await sa.login(cred, prefs);
                              final data = response['data'];
                              if (data['error'] == null &&
                                  data['status'] == null) {
                                widget.currentUser =
                                    User.parse(data, widget.theme);
                                widget.currentUser.password = cred['password']!;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return Home(
                                    font: widget.font,
                                    theme: widget.theme,
                                    currentUser: widget.currentUser,
                                  );
                                }));
                              } else {
                                email.clear();
                                password.clear();
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "LOG IN",
                                style: widget.font.getPoppinsTextStyle(
                                    color: widget.theme.textPrimary,
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
                        style: widget.font.getPoppinsTextStyle(
                            color: widget.theme.borderColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0)),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return RegistrationPage(
                                theme: widget.theme,
                                font: widget.font,
                                currentUser: widget.currentUser);
                          }));
                        },
                        child: Text(
                          "SIGN UP",
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
        ),
      ),
    );
  }
}
