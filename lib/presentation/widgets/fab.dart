import 'package:carbon_icons/carbon_icons.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/presentation/widgets/expenseAdd.dart';
import 'package:coinwatcher/routes/popUpAnimateRoute.dart';
import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  Fab({super.key, required this.theme, required this.font, required this.currentUser});

  LightMode theme;
  FontFamily font;
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(HeroDialogRoute(
              builder: (context) => Align(
                  alignment: Alignment.bottomCenter,
                  child: ExpenseAdd(
                      currentUser: currentUser, theme: theme, font: font))));
        },
        backgroundColor: theme.primaryAccent4,
        child: Icon(CarbonIcons.add, size: 30, color: theme.textPrimary));
  }
}
