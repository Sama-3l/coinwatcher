part of 'date_picker_bloc.dart';

@immutable
abstract class DatePickerState {}

class DatePickerInitial extends DatePickerState {}

class UpdateDateState extends DatePickerState {}