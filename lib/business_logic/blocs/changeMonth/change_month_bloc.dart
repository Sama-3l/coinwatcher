import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_month_event.dart';
part 'change_month_state.dart';

class ChangeMonthBloc extends Bloc<ChangeMonthEvent, ChangeMonthState> {
  ChangeMonthBloc() : super(ChangeMonthInitial()) {
    on<UpdateMonthEvent>((event, emit) {
      emit(UpdateMonthState());
    });
  }
}
