// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_entity.freezed.dart';
part 'food_entity.g.dart';

@freezed
class FoodEntity with _$FoodEntity {
  const factory FoodEntity(
      {@JsonKey(name: 'idMeal') String? id,
      @JsonKey(name: 'strMeal') String? name,
      @JsonKey(name: 'strCategory') String? category,
      @JsonKey(name: 'strArea') String? area,
      @JsonKey(name: 'strInstructions') String? instructions,
      @JsonKey(name: 'strMealThumb') String? thumbnail,
      @JsonKey(name: '') String? tag,
      List<String>? ingredients,
      List<String>? measures}) = _FoodEntity;

  factory FoodEntity.fromJson(Map<String, Object?> json) =>
      _$FoodEntityFromJson(json);

  factory FoodEntity.fromMap(Map<String, Object?> map) => FoodEntity(
      id: map['idMeal'] as String?,
      name: map['strMeal'] as String?,
      category: map['strCategory'] as String?,
      area: map['strArea'] as String?,
      instructions: map['strInstructions'] as String?,
      thumbnail: map['strMealThumb'] as String?,
      tag: map['strTags'] as String?,
      ingredients: (map['ingredients'] as String?)?.split(',').toList(),
      measures: (map['measures'] as String?)?.split(',').toList());
}
