part of 'food_detail_bloc.dart';

abstract class FoodDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoodDetailGetFoodEvent extends FoodDetailEvent {
  final String id;

  FoodDetailGetFoodEvent(this.id);

  @override
  List<Object> get props => [id];
}
