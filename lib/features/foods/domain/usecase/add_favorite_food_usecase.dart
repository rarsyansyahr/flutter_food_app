import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class AddFavoriteFoodUsecase {
  final FoodRepository foodRepositoryImpl;

  AddFavoriteFoodUsecase(this.foodRepositoryImpl);

  Future<int> call(bool isFavorite, FoodEntity food) async =>
      foodRepositoryImpl.createFavoriteFood(isFavorite, food);
}
