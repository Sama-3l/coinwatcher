// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  LightMode lightMode = LightMode();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(theme: lightMode)
    );
  }
}