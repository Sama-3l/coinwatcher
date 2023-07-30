import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bar_graph_change_event.dart';
part 'bar_graph_change_state.dart';

class BarGraphChangeBloc extends Bloc<BarGraphChangeEvent, BarGraphChangeState> {
  BarGraphChangeBloc() : super(BarGraphChangeInitial()) {
    on<ChangeGraphEvent>((event, emit) {
      emit(ChangeGraphState());
    });
  }
}
