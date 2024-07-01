import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

abstract class FoodRepository {
  Future<List<FoodEntity>> getFoods();
}
