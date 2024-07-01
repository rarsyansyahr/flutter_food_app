import 'package:dio/dio.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FoodApi {
  final Dio dio;

  FoodApi({required this.dio});

  Future<List<FoodEntity>> getFoods() async {
    final response = await dio.get("/search.php?s=");

    return List<Map<String, dynamic>>.from(response.data['meals'])
        .map((item) => FoodEntity.fromJson(item))
        .toList();
  }
}
