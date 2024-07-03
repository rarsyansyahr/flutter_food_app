part of 'food_detail_bloc.dart';

abstract class FoodDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodDetailInitialState extends FoodDetailState {}

class FoodDetailLoadingState extends FoodDetailState {}

class FoodDetailGetFoodSuccessState extends FoodDetailState {
  final FoodEntity food;
  final bool isFavorite;

  FoodDetailGetFoodSuccessState({required this.food, required this.isFavorite});

  @override
  List<Object> get props => [food, isFavorite];
}

class FoodDetailGetFoodErrorState extends FoodDetailState {
  final String message;
  FoodDetailGetFoodErrorState(this.message);

  @override
  List<Object> get props => [message];
}
