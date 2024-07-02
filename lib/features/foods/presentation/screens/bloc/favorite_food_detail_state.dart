part of 'favorite_food_detail_bloc.dart';

class FavoriteFoodDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteFoodDetailInitialState extends FavoriteFoodDetailState {}

class FavoriteFoodDetailLoadingState extends FavoriteFoodDetailState {}

class FavoriteFoodDetailGetFoodSuccessState extends FavoriteFoodDetailState {
  final FoodEntity food;

  FavoriteFoodDetailGetFoodSuccessState(this.food);

  @override
  List<Object?> get props => [food];
}

class FavoriteFoodDetailGetFoodErrorState extends FavoriteFoodDetailState {
  final String message;

  FavoriteFoodDetailGetFoodErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
