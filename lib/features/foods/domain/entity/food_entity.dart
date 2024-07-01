// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_entity.freezed.dart';
part 'food_entity.g.dart';

@freezed
class FoodEntity with _$FoodEntity {
  const factory FoodEntity({
    @JsonKey(name: 'idMeal') String? id,
    @JsonKey(name: 'strMeal')String? name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strMealThumb') String? thumbnail,
    @JsonKey(name: 'strTags') String? tags,
    @JsonKey(name: 'strYoutube') String? youtubeURL,
  }) = _FoodEntity;

  factory FoodEntity.fromJson(Map<String, Object?> json) =>
      _$FoodEntityFromJson(json);
}