import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/utils/split_food_fields_util.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FoodApi {
  final Dio dio;
  final SplitFoodFieldsUtil splitFoodFieldsUtil;

  FoodApi({required this.dio, required this.splitFoodFieldsUtil});

  Future<List<FoodEntity>> getFoods() async {
    final response = await dio.get("/search.php?s=");

    return List<Map<String, dynamic>>.from(response.data['meals']).map((item) {
      item['ingredients'] =
          splitFoodFieldsUtil.splitFields(item, "strIngredient");
      item['measures'] = splitFoodFieldsUtil.splitFields(item, "strMeasure");

      return FoodEntity.fromJson(item);
    }).toList();
  }
}
