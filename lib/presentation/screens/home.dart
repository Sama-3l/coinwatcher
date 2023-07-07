import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/analytics.dart';
import 'package:coinwatcher/presentation/screens/spendings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottomNavBar.dart';
import '../widgets/fab.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LightMode theme = LightMode();
  FontFamily font = FontFamily();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: theme.mainBackground,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: BottomNavBarTabs(theme: theme, font: font),
            bottomNavigationBar: BottomNavBar(theme: theme, font: font),
            floatingActionButton: Fab(font: font, theme: theme),
          )),
    );
  }
}
