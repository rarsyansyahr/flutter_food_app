part of 'food_list_bloc.dart';

abstract class FoodListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodListGetFoodsEvent extends FoodListEvent {}
