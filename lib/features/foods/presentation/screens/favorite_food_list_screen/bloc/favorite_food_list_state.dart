part of 'favorite_food_list_bloc.dart';

abstract class FavoriteFoodListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteFoodListInitialState extends FavoriteFoodListState {}

class FavoriteFoodListLoadingState extends FavoriteFoodListState {}

class FavoriteFoodListGetFoodsSuccessState extends FavoriteFoodListState {
  final List<FoodEntity> foods;
  FavoriteFoodListGetFoodsSuccessState(this.foods);

  @override
  List<Object?> get props => [foods];
}

class FavoriteFoodListGetFoodsErrorState extends FavoriteFoodListState {
  final String message;
  FavoriteFoodListGetFoodsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
