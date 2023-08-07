// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class ExpenseInputField extends StatefulWidget {
  ExpenseInputField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.theme,
      required this.font,
      this.readOnly = false,
      this.currency = false,
      this.fontSize = 18,
      this.passwordIcon = false});

  TextEditingController textEditingController;
  String hintText;
  LightMode theme;
  FontFamily font;
  bool readOnly;
  double fontSize;
  bool currency;
  bool passwordIcon;

  @override
  State<ExpenseInputField> createState() => _ExpenseInputFieldState();
}

class _ExpenseInputFieldState extends State<ExpenseInputField> {

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        obscureText: _isPasswordVisible,
        controller: widget.textEditingController,
        readOnly: widget.readOnly,
        textCapitalization: TextCapitalization.sentences,
        style: widget.font.getPoppinsTextStyle(
            color: widget.theme.textPrimary,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.41),
        decoration: InputDecoration(
          prefix: widget.currency
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    '\u20B9',
                    style: widget.font.getPoppinsTextStyle(
                        color: widget.theme.textPrimary,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.41),
                  ),
                )
              : null,
          hintStyle: widget.font.getPoppinsTextStyle(
              color: widget.theme.textHint,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.41),
          hintText: widget.hintText,
          border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,
          suffixIcon: widget.passwordIcon ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: widget.theme.textHint,
                  ),
                  onPressed: _togglePasswordVisibility,
                ) : null,
        ),
      ),
    );
  }
}
