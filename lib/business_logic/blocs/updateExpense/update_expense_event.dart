part of 'update_expense_bloc.dart';

@immutable
abstract class UpdateExpenseEvent {}

class ExpenseChangedEvent extends UpdateExpenseEvent {}