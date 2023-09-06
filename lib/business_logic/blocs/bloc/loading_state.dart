part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {}

class LoadingInitial extends LoadingState {}

class LoadingStateChange extends LoadingState {}