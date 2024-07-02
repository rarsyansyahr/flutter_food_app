part of 'main_foods_bloc.dart';

abstract class MainFoodsEvent extends Equatable {
  const MainFoodsEvent();

  @override
  List<Object> get props => [];
}

class MainFoodsPageTappedEvent extends MainFoodsEvent {
  final int index;

  const MainFoodsPageTappedEvent({required this.index});

  @override
  List<Object> get props => [index];
}
