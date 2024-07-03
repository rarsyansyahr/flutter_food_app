import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_foods_event.dart';
part 'main_foods_state.dart';

class MainFoodsBloc extends Bloc<MainFoodsEvent, MainFoodsState> {
  MainFoodsBloc() : super(const MainFoodsState(selectedIndex: 0)) {
    on<MainFoodsPageTappedEvent>(mainFoodsPageTappedEvent);
  }

  void mainFoodsPageTappedEvent(
      MainFoodsPageTappedEvent event, Emitter<MainFoodsState> emit) {
    emit(MainFoodsState(selectedIndex: event.index));
  }
}
