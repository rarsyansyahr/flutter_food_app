import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class GetFavoriteFoodDetailUsage {
  final FoodRepository foodRepositoryImpl;

  GetFavoriteFoodDetailUsage(this.foodRepositoryImpl);

  Future<FoodEntity?> call(String id) async =>
      foodRepositoryImpl.getFavoriteFood(id);
}
