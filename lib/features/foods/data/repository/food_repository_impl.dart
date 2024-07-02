import 'package:flutter_food_app/features/foods/data/api/food_api.dart';
import 'package:flutter_food_app/features/foods/data/database/food_database.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodApi foodApi;
  final FoodDatabaseProvider foodDatabaseProvider;

  FoodRepositoryImpl(
      {required this.foodApi, required this.foodDatabaseProvider});

  @override
  Future<List<FoodEntity>> getFoods() => foodApi.getFoods();

  @override
  Future<FoodEntity> getFood(String id) => foodApi.getFood(id);

  @override
  Future<List<FoodEntity>> getFavoriteFoods() =>
      foodDatabaseProvider.getFoods();

  @override
  Future<FoodEntity?> getFavoriteFood(String id) =>
      foodDatabaseProvider.getFood(id);

  @override
  Future<int> createFavoriteFood(bool isFavorite, FoodEntity food) =>
      foodDatabaseProvider.createFood(food);

  @override
  Future<int> removeFavoriteFood(String id) =>
      foodDatabaseProvider.deleteFood(id);
}
