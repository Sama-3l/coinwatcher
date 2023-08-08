// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:coinwatcher/presentation/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'business_logic/blocs/changeMonth/change_month_bloc.dart';
import 'business_logic/blocs/datePicker/date_picker_bloc.dart';
import 'business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';
import 'business_logic/blocs/tabTextBloc/tab_text_color_bloc.dart';
import 'business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'presentation/screens/spendings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TabTextColorBloc()),
          BlocProvider(create: (context) => DropDownMenuBloc()),
          BlocProvider(create: (context) => DatePickerBloc()),
          BlocProvider(create: (context) => UpdateExpenseBloc()),
          BlocProvider(create: (context) => ChangeMonthBloc()),
          BlocProvider(create: (context) => BarGraphChangeBloc()),
          BlocProvider(create: (context) => PasswordVisibilityBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ));
  }
}
