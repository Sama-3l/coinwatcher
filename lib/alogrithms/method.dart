//Put normal functions here that are supposed to run logic

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/data/model/bar_data.dart';
import 'package:coinwatcher/data/model/dayExpense.dart';
import 'package:coinwatcher/data/model/expense.dart';
import 'package:coinwatcher/data/model/month.dart';
import 'package:coinwatcher/data/model/pieData.dart';
import 'package:coinwatcher/data/model/user.dart' as UserModel;
import 'package:coinwatcher/data/repositories/allExpenses.dart';
import 'package:coinwatcher/data/repositories/categories.dart';
import 'package:coinwatcher/data/repositories/days.dart';
import 'package:coinwatcher/data/repositories/recentExpenses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../business_logic/blocs/datePicker/date_picker_bloc.dart';
import '../business_logic/blocs/updateExpense/update_expense_bloc.dart';
import '../data/repositories/months.dart';

class Methods {
  String getMonthandYear({required DateTime date, bool commaReq = true}) {
    return commaReq ? DateFormat('MMMM, yyyy').format(date) : DateFormat('MMMM d').format(date);
  }

  String decimalPart(double amount) {
    return ".${(amount.ceilToDouble() - amount).toInt().toString().padLeft(2, '0')}";
  }

  double getCurrentMonthAmount(RecentExpenses recentExpenses) {
    double sum = 0;
    for (int i = 0; i < recentExpenses.recentExpenses.length; i++) {
      sum = sum + recentExpenses.recentExpenses[i].amount;
    }
    return sum;
  }

  RecentExpenses getRecentExpenses(AllExpenses allExpenses) {
    RecentExpenses recentExpenses = RecentExpenses();
    if (allExpenses.allExpenses.isNotEmpty) {
      if (allExpenses.allExpenses[0].date.month == DateTime.now().month) {
        for (int i = 0; i < allExpenses.allExpenses.length; i++) {
          if (allExpenses.allExpenses[i].date.month == DateTime.now().month) {
            recentExpenses.recentExpenses.add(allExpenses.allExpenses[i]);
          } else {
            break;
          }
        }
      } else if (allExpenses.allExpenses.length > 1) {
        var currentMonth = allExpenses.allExpenses[0].date.month;
        for (int i = 0; i < allExpenses.allExpenses.length; i++) {
          if (allExpenses.allExpenses[i].date.month == currentMonth) {
            recentExpenses.recentExpenses.add(allExpenses.allExpenses[i]);
          } else {
            break;
          }
        }
      }
    }

    return recentExpenses;
  }

  double monthlyBudget(double dailyBudget) {
    return dailyBudget * DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }

  Future<DateTime?> editDate(BuildContext context, DateTime initialDate, LightMode theme) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      ),
      firstDate: DateTime(
        initialDate.year,
        initialDate.month,
        1,
      ),
      lastDate: DateTime(
        initialDate.year + 5,
        initialDate.month,
        initialDate.day,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.grey[800],
            colorScheme: ColorScheme.light(
              primary: theme.mainBackground,
              onPrimary: theme.textPrimary,
              onSurface: theme.activeNavBarButton,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.activeNavBarButton,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    BlocProvider.of<DatePickerBloc>(context).add(UpdateDateEvent());

    return picked;
  }

  String monthCommaYear(DateTime date) {
    return DateFormat('MMMM, yyyy').format(date);
  }

  void addMonthnCategories(UserModel.User currentUser, Expense expense, LightMode theme) {
    // Check if month exists
    if (currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] != null) {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent = currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent + expense.amount;

      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories.categories[expense.category]!.amount = currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories.categories[expense.category]!.amount + expense.amount;
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(date: DateTime(expense.date.year, expense.date.month), totalSpent: expense.amount, categories: Categories(theme: theme));
    }
  }

  void loadCategories(UserModel.User currentUser, Expense expense) {
    currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories.categories[expense.category]!.amount = currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.categories.categories[expense.category]!.amount + expense.amount;
  }

  //To initialize months can remove later it's better to just add a single entry as we actually need to do.
  void loadMonths(UserModel.User currentUser, LightMode theme) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    if (allExpenses.isNotEmpty) {
      for (int i = allExpenses.length - 1; i >= 0; i--) {
        if (DateTime.now().month == allExpenses[i].date.month) {
          currentUser.thisMonthSpent = currentUser.thisMonthSpent + allExpenses[i].amount;
        }

        if (currentUser.monthsDB.allMonths.isNotEmpty) {
          if (currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] != null) {
            currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)]!.totalSpent = currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)]!.totalSpent;
            loadCategories(currentUser, allExpenses[i]);
          } else {
            currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] = Month(date: DateTime(allExpenses[i].date.year, allExpenses[i].date.month), totalSpent: allExpenses[i].amount, categories: Categories(theme: theme));
            addMonthnCategories(currentUser, allExpenses[i], theme);
          }
        } else {
          currentUser.monthsDB.allMonths[monthCommaYear(allExpenses[i].date)] = Month(
            date: DateTime(allExpenses[i].date.year, allExpenses[i].date.month),
            totalSpent: 0,
            categories: Categories(theme: theme),
          );
          addMonthnCategories(currentUser, allExpenses[i], theme);
        }
      }
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(DateTime.now())] = Month(date: DateTime(DateTime.now().year, DateTime.now().month), totalSpent: 0.0, categories: Categories(theme: theme));
    }
  }

  void addToMonthDB(UserModel.User currentUser, Expense expense, LightMode theme) {
    if (currentUser.monthsDB.allMonths.isNotEmpty) {
      if (currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] != null) {
        currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent = currentUser.monthsDB.allMonths[monthCommaYear(expense.date)]!.totalSpent + expense.amount;
        loadCategories(currentUser, expense);
      } else {
        currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(date: DateTime(expense.date.year, expense.date.month), totalSpent: expense.amount, categories: Categories(theme: theme));
        addMonthnCategories(currentUser, expense, theme);
      }
    } else {
      currentUser.monthsDB.allMonths[monthCommaYear(expense.date)] = Month(date: DateTime(expense.date.year, expense.date.month), totalSpent: expense.amount, categories: Categories(theme: theme));
      addMonthnCategories(currentUser, expense, theme);
    }
  }

  void loadDays(UserModel.User currentUser) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    if (allExpenses.isNotEmpty) {
      currentUser.daysDB.allDays[allExpenses[0].date.day.toString().padLeft(2, '0')] = DayExpense(date: allExpenses[0].date, amount: allExpenses[0].amount);
      for (int i = 0; i < 10; i++) {
        currentUser.daysDB.allDays[allExpenses[0].date.subtract(Duration(days: i)).day.toString().padLeft(2, '0')] = DayExpense(date: allExpenses[0].date.subtract(Duration(days: i)), amount: 0.0);
      }
      for (int i = 0; i < allExpenses.length; i++) {
        if (currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')] != null) {
          if (currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!.date.difference(allExpenses[i].date).inDays == 0) {
            double currentAmount = currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!.amount;
            currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')] = DayExpense(date: allExpenses[i].date, amount: currentAmount + allExpenses[i].amount);
          }
        }
      }
    }
  }

  void addToDayDb(UserModel.User currentUser) {
    List<Expense> allExpenses = currentUser.allExpenses.allExpenses;
    currentUser.daysDB.allDays.clear();
    if (allExpenses.isNotEmpty) {
      for (int i = 0; i < 10; i++) {
        currentUser.daysDB.allDays[allExpenses[0].date.subtract(Duration(days: i)).day.toString().padLeft(2, '0')] = DayExpense(date: allExpenses[0].date.subtract(Duration(days: i)), amount: 0.0);
      }
    }
    for (int i = 0; i < allExpenses.length; i++) {
      if (currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')] != null) {
        if (currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!.date.difference(allExpenses[i].date).inDays == 0) {
          currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!.amount = currentUser.daysDB.allDays[allExpenses[i].date.day.toString().padLeft(2, '0')]!.amount + allExpenses[i].amount;
        }
      }
    }
  }

  void addExpenseFab(UserModel.User currentUser, Expense thisExpense, BuildContext context, LightMode theme) {
    if (DateTime.now().month == thisExpense.date.month) {
      currentUser.thisMonthSpent = currentUser.thisMonthSpent + thisExpense.amount;
    }
    int datePositionRelation = 0;
    List<int> indices = [];
    int dateIndex = currentUser.allExpenses.allExpenses.indexWhere((element) {
      datePositionRelation = element.date.difference(thisExpense.date).inDays;
      indices.add(datePositionRelation);
      return element.date.difference(thisExpense.date).inDays == 0;
    });
    int middleDate = indices.indexWhere((element) => element > 0);
    if (dateIndex == -1) {
      if (datePositionRelation < 0) {
        dateIndex = middleDate + 1;
      } else {
        dateIndex = currentUser.allExpenses.allExpenses.length;
      }
    }
    currentUser.allExpenses.allExpenses.insert(dateIndex, thisExpense);
    currentUser.recentExpenses = getRecentExpenses(currentUser.allExpenses);
    addToMonthDB(currentUser, thisExpense, theme);
    addToDayDb(currentUser);
    Navigator.of(context).pop();
    BlocProvider.of<UpdateExpenseBloc>(context).add(ExpenseChangedEvent());
  }

  void removeFromMonthDb(Months monthsDB, Expense? expense) {
    monthsDB.allMonths[getMonthandYear(date: expense!.date)]!.totalSpent -= expense.amount;
    monthsDB.allMonths[getMonthandYear(date: expense.date)]!.categories.categories[expense.category]!.amount -= expense.amount;
  }

  void updateExpenseFab(Expense? originalExpense, UserModel.User currentUser, Expense thisExpense, BuildContext context, LightMode theme) {
    currentUser.allExpenses.allExpenses.remove(originalExpense);
    removeFromMonthDb(currentUser.monthsDB, originalExpense);
    if (DateTime.now().month == thisExpense.date.month) {
      currentUser.thisMonthSpent = currentUser.thisMonthSpent + thisExpense.amount;
    }
    int datePositionRelation = 0;
    List<int> indices = [];
    int dateIndex = currentUser.allExpenses.allExpenses.indexWhere((element) {
      datePositionRelation = element.date.difference(thisExpense.date).inDays;
      indices.add(datePositionRelation);
      return element.date.difference(thisExpense.date).inDays == 0;
    });
    int middleDate = indices.indexWhere((element) => element > 0);
    if (dateIndex == -1) {
      if (datePositionRelation < 0) {
        dateIndex = middleDate + 1;
      } else {
        dateIndex = currentUser.allExpenses.allExpenses.length;
      }
    }
    currentUser.allExpenses.allExpenses.insert(dateIndex, thisExpense);
    currentUser.recentExpenses = getRecentExpenses(currentUser.allExpenses);
    addToMonthDB(currentUser, thisExpense, theme);
    addToDayDb(currentUser);
    Navigator.of(context).pop();
    BlocProvider.of<UpdateExpenseBloc>(context).add(ExpenseChangedEvent());
  }

  void deleteExpense(UserModel.User currentUser, Expense? expense, BuildContext context) {
    currentUser.allExpenses.allExpenses.remove(expense);
    currentUser.recentExpenses = getRecentExpenses(currentUser.allExpenses);
    removeFromMonthDb(currentUser.monthsDB, expense);
    addToDayDb(currentUser);
    Navigator.of(context).pop();
    BlocProvider.of<UpdateExpenseBloc>(context).add(ExpenseChangedEvent());
  }

  List<barDataMonthly> initializeMonthlyGraphDatabase(UserModel.User currentUser, LightMode theme) {
    List<barDataMonthly> data = [];
    currentUser.monthsDB.allMonths.forEach((key, value) {
      data.add(barDataMonthly(
        month: DateFormat.MMM().format(value.date),
        spent: value.totalSpent.ceil(),
        color: theme.foodNDrinks,
      ));
    });
    if (data.isEmpty) {
      data.add(barDataMonthly(
        month: DateFormat.MMM().format(DateTime.now()),
        spent: 0,
        color: theme.foodNDrinks,
      ));
    }
    return data;
  }

  List<barDataDaily> initializeDailyGraphDatabase(UserModel.User currentUser, LightMode theme) {
    List<barDataDaily> data = [];
    currentUser.daysDB.allDays.forEach((key, value) {
      data.add(
        barDataDaily(
          day: key,
          spent: value.amount.ceil(),
          color: theme.foodNDrinks,
        ),
      );
    });
    if (data.isEmpty) {
      for (int i = 0; i < 10; i++) {
        data.add(
          barDataDaily(
            day: DateTime.now().subtract(Duration(days: i)).day.toString().padLeft(2, '0'),
            spent: 0,
            color: theme.foodNDrinks,
          ),
        );
      }
    }
    return data.reversed.toList();
  }

  List<String> categoryMenu() {
    Categories categories = Categories(theme: LightMode());
    List<String> list = [];
    categories.categories.forEach((key, value) {
      list.add(key);
    });

    return list;
  }

  List<String> analyticsMenu(UserModel.User currentUser) {
    List<String> list = [];

    currentUser.monthsDB.allMonths.forEach((key, value) {
      list.add(DateFormat('MMMM, y').format(value.date));
    });
    if (list.isEmpty) {
      list.add(DateFormat('MMMM, y').format(DateTime.now()));
    }
    return list;
  }

  List<PieData> generatePieGraphData(Categories categories, LightMode theme) {
    List<PieData> pieData = [];
    categories.categories.forEach((key, value) {
      pieData.add(PieData(category: value.name, spent: value.amount.ceil(), color: value.color));
    });
    return pieData;
  }

  String getTotalAmount(Categories categories) {
    double totalAmount = 0;
    categories.categories.forEach((key, value) {
      totalAmount = totalAmount + value.amount;
    });
    return totalAmount.ceil().toString();
  }

  String getDropDownDefaultValue(RecentExpenses recentExpenses) {
    if (recentExpenses.recentExpenses.isEmpty) {
      return DateFormat('MMMM, y').format(DateTime.now());
    } else {
      if (recentExpenses.recentExpenses[0].date.month == DateTime.now().month && recentExpenses.recentExpenses[0].date.year == DateTime.now().year) {
        return DateFormat('MMMM, y').format(DateTime.now());
      } else {
        return DateFormat('MMMM, y').format(recentExpenses.recentExpenses[0].date);
      }
    }
  }

  double calculateDailyBudget(double monthlyBudget) {
    return monthlyBudget / DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }

  DateTime dateTimeObjectFormat(String date) {
    RegExp regex = RegExp(r'\d+');
    Iterable<Match> matches = regex.allMatches(date);
    List<int> numbers = [];

    for (Match match in matches) {
      numbers.add(int.parse(match.group(0)!));
    }
    return numbers.length == 3 ? DateTime(numbers[0], numbers[1], numbers[2]) : DateTime(numbers[0], numbers[1]);
  }

  Future<UserModel.User?> loginUser(String email, String password, LightMode theme) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the signed-in user
      User? user = userCredential.user;
      UserModel.User? currentUserData;

      // Fetch user data from Firestore
      if (user != null) {
        DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();

        // Assuming you want to return the user data
        if (userData.exists) {
          print("HELLO");
          currentUserData = UserModel.User.parse(userData.data() as Map<String, dynamic>, theme);
        }
      }
      return currentUserData;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<UserModel.User?> signUpUser(String email, String password, String userName) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      // Sign in with email and password
      print(email);
      print(password);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.toString().trim(),
        password: password.toString().trim(),
      );

      // Get the signed-in user
      User? user = userCredential.user;
      UserModel.User currentUser = UserModel.User(
        id: user!.uid,
        name: userName,
        email: user.email!,
        recentExpenses: RecentExpenses(),
        dailyBudget: 250.0,
        thisMonthSpent: 0.0,
        allExpenses: AllExpenses(),
        monthsDB: Months(),
        daysDB: Days(),
      );

      // Fetch user data from Firestore
      await _firestore.collection('users').doc(user.uid).set(currentUser.toJSON());

      return currentUser;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  double currentMonthSpent(UserModel.User currentUser) {
    return currentUser.monthsDB.allMonths[monthCommaYear(DateTime.now())]!.totalSpent;
  }

  void categoriesPatch(AllExpenses allExpenses, Categories categories, String month) {
    DateTime currentMonth = DateTime(int.parse(month.split('-')[0]), int.parse(month.split('-')[1]));
    int p = 0;
    for (var expense in allExpenses.allExpenses) {
      if (expense.date.month == currentMonth.month && expense.date.year == currentMonth.year) {
        p = 1;
        categories.categories[expense.category]!.amount = categories.categories[expense.category]!.amount + expense.amount;
      } else if (p == 1) {
        break;
      }
    }
  }

  Future<UserModel.User> getLogInUserData(LightMode theme) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    UserModel.User? currentUserData;
    if (_auth.currentUser != null) {
      DocumentSnapshot userData = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

      // Assuming you want to return the user data
      if (userData.exists) {
        currentUserData = UserModel.User.parse(userData.data() as Map<String, dynamic>, theme);
        return currentUserData;
      } else {
        return UserModel.User(
          id: "",
          name: "",
          email: "",
          recentExpenses: RecentExpenses(),
          dailyBudget: 0.0,
          thisMonthSpent: 0.0,
          allExpenses: AllExpenses(),
          monthsDB: Months(),
          daysDB: Days(),
        );
      }
    }
    return UserModel.User(
      id: "",
      name: "",
      email: "",
      recentExpenses: RecentExpenses(),
      dailyBudget: 0.0,
      thisMonthSpent: 0.0,
      allExpenses: AllExpenses(),
      monthsDB: Months(),
      daysDB: Days(),
    );
  }
}
