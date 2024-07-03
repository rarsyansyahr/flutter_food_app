import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/utils/split_food_fields_util.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FoodApi {
  final Dio dio;
  final SplitFoodFieldsUtil splitFoodFieldsUtil;

  FoodApi({required this.dio, required this.splitFoodFieldsUtil});

  Future<List<FoodEntity>> getFoods() async {
    try {
      final response = await dio.get("/search.php?s=");

      return List<Map<String, dynamic>>.from(response.data['meals'])
          .map((food) {
        food['ingredients'] =
            splitFoodFieldsUtil.splitFields(food, "strIngredient");
        food['measures'] = splitFoodFieldsUtil.splitFields(food, "strMeasure");
        food['strTags'] = _stringToList(food['strTags']);

        return FoodEntity.fromJson(food);
      }).toList();
    } catch (e) {
      // print(e);

      return [];
    }
  }

  Future<FoodEntity> getFood(String id) async {
    final response = await dio.get("/lookup.php?i=$id");
    final food = response.data['meals'][0];

    food['ingredients'] =
        splitFoodFieldsUtil.splitFields(food, "strIngredient");
    food['measures'] = splitFoodFieldsUtil.splitFields(food, "strMeasure");
    food['strTags'] = _stringToList(food['strTags']);

    return FoodEntity.fromJson(food);
  }

  List<String> _stringToList(String? value) {
    if (value == null || value == "") {
      return [];
    }

    return value.split(",").map((item) => item.trim()).toList();
  }
}
