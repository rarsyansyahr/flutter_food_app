import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class GetFoodsUseCase {
  final FoodRepository foodRepositoryImpl;

  GetFoodsUseCase(this.foodRepositoryImpl);

  Future<List<FoodEntity>> call() async => foodRepositoryImpl.getFoods();
}
