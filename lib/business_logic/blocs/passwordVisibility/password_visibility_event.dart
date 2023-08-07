part of 'password_visibility_bloc.dart';

@immutable
abstract class PasswordVisibilityEvent {}

class VisibilityChangedEvent extends PasswordVisibilityEvent{}
