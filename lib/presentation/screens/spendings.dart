import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class Spendings extends StatefulWidget {
  Spendings({super.key, required this.theme});

  LightMode theme;

  @override
  State<Spendings> createState() => _SpendingsState();
}

class _SpendingsState extends State<Spendings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      body: Container(),
    );
  }
}
