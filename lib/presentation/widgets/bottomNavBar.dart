// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/analytics.dart';
import 'package:coinwatcher/presentation/screens/dashboard.dart';
import 'package:coinwatcher/presentation/screens/spendings.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.theme});

  LightMode theme;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 350 / 80,
      child: Container(
          decoration: BoxDecoration(
              color: widget.theme.textPrimary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: TabBar(
              labelColor: widget.theme.inactiveNavBarButton,
              indicator: BoxDecoration(),
              unselectedLabelColor: widget.theme.inactiveNavBarButton,
              tabs: [
                Tab(icon: Icon(Icons.home, size: 30), text: "Home"),
                Tab(icon: Icon(Icons.shuffle, size: 30), text: "Spendings"),
                Tab(icon: Icon(Icons.bar_chart, size: 30), text: "Analytics")
              ])),
    );
  }
}

class BottomNavBarTabs extends StatefulWidget {
  BottomNavBarTabs({super.key, required this.theme});

  LightMode theme;

  @override
  State<BottomNavBarTabs> createState() => _BottomNavBarTabsState();
}

class _BottomNavBarTabsState extends State<BottomNavBarTabs> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Dashboard(theme: widget.theme),
      Spendings(theme: widget.theme),
      Analytics(theme: widget.theme)
    ]);
  }
}
