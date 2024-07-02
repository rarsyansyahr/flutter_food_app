import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';

class RemoveFavoriteFoodUsecase {
  final FoodRepository foodRepositoryImpl;

  RemoveFavoriteFoodUsecase(this.foodRepositoryImpl);

  Future<int> call(String id) => foodRepositoryImpl.removeFavoriteFood(id);
}
