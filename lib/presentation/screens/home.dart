import 'package:coinwatcher/alogrithms/method.dart';
import 'package:coinwatcher/business_logic/blocs/datePicker/date_picker_bloc.dart';
import 'package:coinwatcher/business_logic/blocs/dropDownMenu/drop_down_menu_bloc.dart';
import 'package:coinwatcher/business_logic/blocs/updateExpense/update_expense_bloc.dart';
import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/user.dart';
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/days.dart';
import 'package:coinwatcher/data/repositories/months.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/tabTextBloc/tab_text_color_bloc.dart';
import '../widgets/bottomNavBar.dart';
import '../widgets/fab.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  LightMode theme = LightMode();
  FontFamily font = FontFamily();
  Methods func = Methods();
  late TabController tabController;
  late User currentUser = User(
      name: 'Samael',
      dailyBudget: 250,
      thisMonthSpent: 0.0,
      allExpenses: AllExpenses(),
      recentExpenses: func.getRecentExpenses(AllExpenses()),
      monthsDB: Months(),
      daysDB: Days());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    func.loadMonths(currentUser, theme);
    func.loadDays(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TabTextColorBloc()),
        BlocProvider(create: (context) => DropDownMenuBloc()),
        BlocProvider(create: (context) => DatePickerBloc()),
        BlocProvider(create: (context) => UpdateExpenseBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: theme.mainBackground,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: BlocBuilder<UpdateExpenseBloc, UpdateExpenseState>(
            builder: (context, state) {
              return BottomNavBarTabs(
                theme: theme,
                font: font,
                tabController: tabController,
                currentUser: currentUser,
              );
            },
          ),
          bottomNavigationBar: BottomNavBar(
              theme: theme, font: font, tabController: tabController),
          floatingActionButton:
              Fab(font: font, theme: theme, currentUser: currentUser),
        ),
      ),
    );
  }
}
