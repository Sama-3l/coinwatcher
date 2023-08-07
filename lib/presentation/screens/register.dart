import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/widgets/expenseInputField.dart';
import 'package:flutter/material.dart';
import 'package:coinwatcher/presentation/widgets/passField.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
  late LightMode theme = LightMode();
  late FontFamily font = FontFamily();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
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
                  textEditingController: email,
                  hintText: "EmailID",
                  theme: widget.theme,
                  font: widget.font),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 10),
              child: ExpenseInputField(
                  textEditingController: email,
                  hintText: "Username",
                  theme: widget.theme,
                  font: widget.font),
            ),
            // Container(
            //   height: 0.06 * height,
            //   width: 0.776 * width,
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Enter your Email-ID",
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(14.0),
            //         borderSide: BorderSide(color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 16, bottom: 16),
            //   child: Container(
            //     height: 0.06 * height,
            //     width: 0.776 * width,
            //     child: TextField(
            //       decoration: InputDecoration(
            //         hintText: "Enter your Username",
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(14.0),
            //           borderSide: BorderSide(color: Colors.black),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            PasswordTextField(
              onPasswordValidityChanged: (isValid) {
                // Perform any actions when the password validity changes.
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Already have an account?",
            //         style: widget.font.getPoppinsTextStyle(
            //             color: Color(0xff000000),
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             letterSpacing: 0)),
            //     TextButton(
            //         onPressed: () {},
            //         child: Text(
            //           "Login",
            //           style: widget.font.getPoppinsTextStyle(
            //               color: Color(0xff475abd),
            //               fontSize: 14,
            //               fontWeight: FontWeight.w600,
            //               letterSpacing: 0),
            //         ))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
