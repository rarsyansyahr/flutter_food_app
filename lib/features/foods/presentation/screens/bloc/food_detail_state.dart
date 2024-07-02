part of 'food_detail_bloc.dart';

abstract class FoodDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class FoodDetailInitialState extends FoodDetailState {}

class FoodDetailLoadingState extends FoodDetailState {}

class FoodDetailGetFoodSuccessState extends FoodDetailState {
  final FoodEntity food;
  FoodDetailGetFoodSuccessState(this.food);

  @override
  List<Object> get props => [food];
}

class FoodDetailGetFoodErrorState extends FoodDetailState {
  final String message;
  FoodDetailGetFoodErrorState(this.message);

  @override
  List<Object> get props => [message];
}
