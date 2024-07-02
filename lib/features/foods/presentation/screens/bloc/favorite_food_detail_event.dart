part of 'favorite_food_detail_bloc.dart';

class FavoriteFoodDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteFoodDetailGetFoodEvent extends FavoriteFoodDetailEvent {
  final String id;

  FavoriteFoodDetailGetFoodEvent(this.id);

  @override
  List<Object?> get props => [id];
}
