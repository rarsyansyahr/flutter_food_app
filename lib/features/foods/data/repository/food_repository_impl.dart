import 'package:flutter_food_app/features/foods/data/api/food_api.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodApi foodApi;

  FoodRepositoryImpl({required this.foodApi});

  @override
  Future<List<FoodEntity>> getFoods() => foodApi.getFoods();

  @override
  Future<FoodEntity> getFood(String id) => foodApi.getFood(id);
}
