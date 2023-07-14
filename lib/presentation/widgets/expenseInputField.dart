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
      this.readOnly = false});

  TextEditingController textEditingController;
  String hintText;
  LightMode theme;
  FontFamily font;
  bool readOnly;

  @override
  State<ExpenseInputField> createState() => _ExpenseInputFieldState();
}

class _ExpenseInputFieldState extends State<ExpenseInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: widget.textEditingController,
        readOnly: widget.readOnly,
        textCapitalization: TextCapitalization.sentences,
        style: widget.font.getPoppinsTextStyle(
            color: widget.theme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.41),
        decoration: InputDecoration(
          hintStyle: widget.font.getPoppinsTextStyle(
              color: widget.theme.textHint,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.41),
          hintText: widget.hintText,
          border: InputBorder.none,
          fillColor: Colors.transparent,
          filled: true,
        ),
      ),
    );
  }
}
