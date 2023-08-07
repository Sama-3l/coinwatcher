import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
  late LightMode theme = LightMode();
  late FontFamily font = FontFamily();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.theme.mainBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 10),
              child: ExpenseInputField(
                  textEditingController: username,
                  hintText: "Username",
                  theme: widget.theme,
                  font: widget.font),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 10),
              child: ExpenseInputField(
                  obscure: true,
                  textEditingController: password,
                  hintText: "password",
                  theme: widget.theme,
                  font: widget.font),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: Container(
                  height: 0.06 * height,
                  width: 0.779 * width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(29))),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(29)),
                      ))),
                      onPressed: () {},
                      child: Text(
                        "LOGIN",
                        style: widget.font.getPoppinsTextStyle(
                            color: Color(0xff2d2d2d),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0),
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: widget.font.getPoppinsTextStyle(
                        color: Color(0xff000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: widget.font.getPoppinsTextStyle(
                          color: Color(0xff475abd),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
