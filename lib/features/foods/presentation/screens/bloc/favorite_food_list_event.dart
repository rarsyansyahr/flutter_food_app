part of 'favorite_food_list_bloc.dart';

class FavoriteFoodListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteFoodListGetFoodsEvent extends FavoriteFoodListEvent {}

class FavoriteFoodListRemoveFoodEvent extends FavoriteFoodListEvent {
  final String id;

  FavoriteFoodListRemoveFoodEvent(this.id);

  @override
  List<Object?> get props => [id];
}
