part of 'update_expense_bloc.dart';

@immutable
abstract class UpdateExpenseState {}

class UpdateExpenseInitial extends UpdateExpenseState {}

class ExpenseChangedState extends UpdateExpenseState {}