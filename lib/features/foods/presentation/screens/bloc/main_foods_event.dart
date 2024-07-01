part of 'main_foods_bloc.dart';

abstract class MainFoodsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainFoodsGetFoodsEvent extends MainFoodsEvent {}
