// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/register.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';

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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ExpenseInputField(
                    passwordIcon: true,
                    textEditingController: password,
                    hintText: "Password",
                    theme: theme,
                    font: font),
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
                            onPressed: () {},
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
