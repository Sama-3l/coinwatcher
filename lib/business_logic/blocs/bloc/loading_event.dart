part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {}

class LoadingNowEvent extends LoadingEvent {}