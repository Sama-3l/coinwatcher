// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart' as UserModel;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottomNavBar.dart';
import '../widgets/fab.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
    required this.font,
    required this.theme,
    required this.currentUser,
  });

  LightMode theme;
  FontFamily font;
  UserModel.User currentUser;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Methods func = Methods();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    if (widget.currentUser.monthsDB.allMonths.isEmpty) {
      func.loadMonths(widget.currentUser, widget.theme);
    }
    func.loadDays(widget.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: BlocBuilder<UpdateExpenseBloc, UpdateExpenseState>(
        builder: (context, state) {
          return BottomNavBarTabs(
            theme: widget.theme,
            font: widget.font,
            tabController: tabController,
            currentUser: widget.currentUser,
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(theme: widget.theme, font: widget.font, tabController: tabController),
      floatingActionButton: Fab(font: widget.font, theme: widget.theme, currentUser: widget.currentUser),
    );
  }
}
