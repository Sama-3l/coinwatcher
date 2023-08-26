// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/alogrithms/widgetDecider.dart';
import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/days.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:coinwatcher/presentation/screens/dashboard.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:coinwatcher/presentation/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'business_logic/blocs/changeMonth/change_month_bloc.dart';
import 'business_logic/blocs/datePicker/date_picker_bloc.dart';
import 'business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';
import 'business_logic/blocs/tabTextBloc/tab_text_color_bloc.dart';
import 'business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'data/model/user.dart';
import 'presentation/screens/spendings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token')));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.token});

  String? token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Methods func = Methods();
  LightMode theme = LightMode();
  FontFamily font = FontFamily();
  late User currentUser = User(
      name: "",
      email: "",
      password: "",
      dailyBudget: 250.0,
      thisMonthSpent: 0.0,
      allExpenses: AllExpenses(),
      recentExpenses: func.getRecentExpenses(AllExpenses()),
      monthsDB: Months(),
      daysDB: Days());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.token);
  }

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
          home: widget.token == null
              ? LoginPage(theme: theme, font: font, currentUser: currentUser)
              : func.tokenIsExpired(widget.token!, currentUser, theme)
                  ? LoginPage(
                      theme: theme, font: font, currentUser: currentUser)
                  : Home(
                      theme: theme, font: font, currentUser: currentUser),
        ));
  }
}
