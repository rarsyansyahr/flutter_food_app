part of 'food_list_bloc.dart';

abstract class FoodListState extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodListInitialState extends FoodListState {}

class FoodListLoadingState extends FoodListState {}

class FoodListGetFoodsSuccessState extends FoodListState {
  final List<FoodEntity> foods;
  final List<FoodEntity> favoriteFoods;
  FoodListGetFoodsSuccessState(
      {required this.foods, required this.favoriteFoods});

  @override
  List<Object> get props => [foods, favoriteFoods];
}

class FoodListGetFoodsErrorState extends FoodListState {
  final String message;
  FoodListGetFoodsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
