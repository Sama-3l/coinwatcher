// ignore_for_file: prefer_const_constructors

import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/bloc/loading_bloc.dart';
import 'package:coinwatcher/business_logic/blocs/passwordVisibility/password_visibility_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/home.dart';
import 'package:coinwatcher/presentation/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/blocs/barGraphChange/bar_graph_change_bloc.dart';
import 'business_logic/blocs/changeMonth/change_month_bloc.dart';
import 'business_logic/blocs/datePicker/date_picker_bloc.dart';
import 'business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';
import 'business_logic/blocs/tabTextBloc/tab_text_color_bloc.dart';
import 'business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isExpired = true;
  Methods func = Methods();
  LightMode theme = LightMode();
  FontFamily font = FontFamily();

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
          BlocProvider(create: (context) => PasswordVisibilityBloc()),
          BlocProvider(create: (context) => LoadingBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser == null
              ? LoginPage(theme: theme, font: font)
              : FutureBuilder(
                  future: func.getLogInUserData(theme),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data!.id == ""
                          ? LoginPage(theme: theme, font: font)
                          : Home(
                              theme: theme,
                              font: font,
                              currentUser: snapshot.data!,
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
        ));
  }
}
