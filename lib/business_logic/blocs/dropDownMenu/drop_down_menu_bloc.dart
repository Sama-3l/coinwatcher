import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drop_down_menu_event.dart';
part 'drop_down_menu_state.dart';

class DropDownMenuBloc extends Bloc<DropDownMenuEvent, DropDownMenuState> {
  DropDownMenuBloc() : super(DropDownMenuInitial()) {
    on<UpdateMenuEvent>((event, emit) {
      emit(UpdateMenuState());
    });
  }
}
