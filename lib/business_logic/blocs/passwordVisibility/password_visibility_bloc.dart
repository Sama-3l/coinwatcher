import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_visibility_event.dart';
part 'password_visibility_state.dart';

class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityInitial()) {
    on<VisibilityChangedEvent>((event, emit) {
      emit(VisibilityChangedState());
    });
  }
}
