import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

abstract class FoodRepository {
  Future<List<FoodEntity>> getFoods();

  Future<FoodEntity> getFood(String id);

  Future<List<FoodEntity>> getFavoriteFoods();

  Future<FoodEntity?> getFavoriteFood(String id);

  Future<int> createFavoriteFood(bool isFavorite, FoodEntity food);

  Future<int> removeFavoriteFood(String id);
}
