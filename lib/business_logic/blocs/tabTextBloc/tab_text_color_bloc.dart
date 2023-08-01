import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_text_color_event.dart';
part 'tab_text_color_state.dart';

class TabTextColorBloc extends Bloc<TabTextColorEvent, TabTextColorState> {
  TabTextColorBloc() : super(TabTextColorInitial()) {
    on<ChangeTabTextColorEvent>((event, emit) {
      emit(ChangeTabTextColorState());
    });
  }
}
