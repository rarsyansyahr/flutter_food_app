part of 'main_foods_bloc.dart';

abstract class MainFoodsState extends Equatable {
  @override
  List<Object> get props => [];
}

class MainFoodsInitialState extends MainFoodsState {}

class MainFoodsLoadingState extends MainFoodsState {}

class MainFoodsGetFoodsSuccessState extends MainFoodsState {
  final List<FoodEntity> foods;
  MainFoodsGetFoodsSuccessState(this.foods);

  @override
  List<Object> get props => [foods];
}

class MainFoodsGetFoodsErrorState extends MainFoodsState {
  final String message;
  MainFoodsGetFoodsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
