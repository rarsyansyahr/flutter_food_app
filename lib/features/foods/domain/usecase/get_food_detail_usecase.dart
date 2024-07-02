import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class GetFoodDetailUseCase {
  final FoodRepository foodRepositoryImpl;

  GetFoodDetailUseCase(this.foodRepositoryImpl);

  Future<FoodEntity> call(String id) async => foodRepositoryImpl.getFood(id);
}
