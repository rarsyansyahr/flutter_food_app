part of 'food_list_bloc.dart';

abstract class FoodListState extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodListInitialState extends FoodListState {}

class FoodListLoadingState extends FoodListState {}

class FoodListGetFoodsSuccessState extends FoodListState {
  final List<FoodEntity> foods;
  FoodListGetFoodsSuccessState(this.foods);

  @override
  List<Object> get props => [foods];
}

class FoodListGetFoodsErrorState extends FoodListState {
  final String message;
  FoodListGetFoodsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
