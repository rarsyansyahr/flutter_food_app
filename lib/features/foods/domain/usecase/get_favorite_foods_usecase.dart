import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class GetFavoriteFoodsUsecase {
  final FoodRepository foodRepositoryImpl;

  GetFavoriteFoodsUsecase(this.foodRepositoryImpl);

  Future<List<FoodEntity>> call() async =>
      foodRepositoryImpl.getFavoriteFoods();
}
