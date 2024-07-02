part of 'food_detail_bloc.dart';

abstract class FoodDetailEvent extends Equatable {
  const FoodDetailEvent();

  @override
  List<Object?> get props => [];
}

class FoodDetailGetFoodEvent extends FoodDetailEvent {
  final String id;

  const FoodDetailGetFoodEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FoodDetailFavoriteTappedEvent extends FoodDetailEvent {
  final bool isFavorite;

  const FoodDetailFavoriteTappedEvent({required this.isFavorite});

  @override
  List<Object> get props => [isFavorite];
}
