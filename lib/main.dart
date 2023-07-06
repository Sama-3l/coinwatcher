// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/spendings.dart';

void main() {
  runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  LightMode theme = LightMode();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(theme: theme)
    );
  }
}