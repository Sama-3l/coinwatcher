// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:coinwatcher/business_logic/blocs/tabTextBloc/tab_text_color_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/presentation/screens/analytics.dart';
import 'package:coinwatcher/presentation/screens/dashboard.dart';
import 'package:coinwatcher/presentation/screens/spendings.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar(
      {super.key,
      required this.theme,
      required this.font,
      required this.tabController});

  LightMode theme;
  FontFamily font;
  TabController tabController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (currentIndex != widget.tabController.index) {
        currentIndex = widget.tabController.index;
        BlocProvider.of<TabTextColorBloc>(context)
            .add(ChangeTabTextColorEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 500 / 80,
      child: Container(
          decoration: BoxDecoration(
              color: widget.theme.textPrimary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: BlocBuilder<TabTextColorBloc, TabTextColorState>(
            builder: (context, state) {
              return TabBar(
                  controller: widget.tabController,
                  labelColor: widget.theme.activeNavBarButton,
                  indicator: BoxDecoration(),
                  unselectedLabelColor: widget.theme.inactiveNavBarButton,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Tab(
                        icon: Icon(CarbonIcons.home, size: 24),
                        iconMargin: EdgeInsets.only(bottom: 8),
                        child: Text('Home',
                            style: widget.font.getPoppinsTextStyle(
                                color: currentIndex == 0
                                    ? widget.theme.activeNavBarButton
                                    : widget.theme.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Tab(
                          icon: Icon(CarbonIcons.repeat, size: 24),
                          iconMargin: EdgeInsets.only(bottom: 8),
                          child: Text('Spendings',
                              style: widget.font.getPoppinsTextStyle(
                                  color: currentIndex == 1
                                      ? widget.theme.activeNavBarButton
                                      : widget.theme.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Tab(
                          icon: Icon(CarbonIcons.chart_cluster_bar, size: 24),
                          iconMargin: EdgeInsets.only(bottom: 8),
                          child: Text('Analytics',
                              style: widget.font.getPoppinsTextStyle(
                                  color: currentIndex == 2
                                      ? widget.theme.activeNavBarButton
                                      : widget.theme.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0))),
                    )
                  ]);
            },
          )),
    );
  }
}

class BottomNavBarTabs extends StatefulWidget {
  BottomNavBarTabs(
      {super.key,
      required this.theme,
      required this.font,
      required this.tabController,
      required this.currentUser});

  LightMode theme;
  FontFamily font;
  TabController tabController;
  User currentUser;

  @override
  State<BottomNavBarTabs> createState() => _BottomNavBarTabsState();
}

class _BottomNavBarTabsState extends State<BottomNavBarTabs> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: widget.tabController, children: [
      Dashboard(
          theme: widget.theme,
          font: widget.font,
          currentUser: widget.currentUser),
      Spendings(
          theme: widget.theme,
          font: widget.font,
          currentUser: widget.currentUser),
      Analytics(
          theme: widget.theme,
          font: widget.font,
          currentUser: widget.currentUser)
    ]);
  }
}
