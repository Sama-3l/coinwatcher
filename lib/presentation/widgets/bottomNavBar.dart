// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/analytics.dart';
import 'package:coinwatcher/presentation/screens/dashboard.dart';
import 'package:coinwatcher/presentation/screens/spendings.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.theme, required this.font});

  LightMode theme;
  FontFamily font;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 500 / 80,
      child: Container(
          decoration: BoxDecoration(
              color: widget.theme.textPrimary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: TabBar(
              labelColor: widget.theme.activeNavBarButton,
              indicator: BoxDecoration(),
              unselectedLabelColor: widget.theme.inactiveNavBarButton,
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Tab(
                    icon: Icon(CarbonIcons.home, size: 20),
                    iconMargin: EdgeInsets.only(bottom: 6),
                    child: Text('Home',
                        style: widget.font.getPoppinsTextStyle(
                            color: widget.theme.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Tab(
                      icon: Icon(CarbonIcons.repeat, size: 20),
                      iconMargin: EdgeInsets.only(bottom: 6),
                      child: Text('Spendings',
                          style: widget.font.getPoppinsTextStyle(
                              color: widget.theme.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Tab(
                      icon: Icon(CarbonIcons.chart_cluster_bar, size: 20),
                      iconMargin: EdgeInsets.only(bottom: 6),
                      child: Text('Analytics',
                          style: widget.font.getPoppinsTextStyle(
                              color: widget.theme.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0))),
                )
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
