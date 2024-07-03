import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Food Entity Test", () {
    late FoodEntity food1;
    late FoodEntity food2;
    late FoodEntity entityReference;
    late Map<String, Object?> jsonReference;

    setUp(() {
      food1 = const FoodEntity(
          id: "1",
          name: "Mendoan",
          category: "Khas",
          area: "Purbalingga",
          tags: ["Murah", "Meriah", "Mewah"],
          thumbnail: "https://picsum.photos/200",
          measures: ["1pcs"],
          ingredients: ["Egg"],
          instructions: "Buy online");

      food2 = const FoodEntity(
          id: "2",
          name: "Mendoan",
          category: "Khas",
          area: "Purbalingga",
          tags: ["Murah", "Meriah", "Mewah"],
          thumbnail: "https://picsum.photos/200",
          measures: ["1pcs"],
          ingredients: ["Egg"],
          instructions: "Buy online");

      entityReference = food1;
      jsonReference = food1.toJson();
    });

    test("Should create FoodEntity instance to or from JSON", () {
      final createEntity = FoodEntity.fromJson(jsonReference);
      final createJson = entityReference.toJson();

      expect(createEntity, entityReference);

      expect(createJson, jsonReference);
    });

    test("Two instances with the same properties should be equal", () {
      FoodEntity food3 = food1;

      expect(food1, equals(food3));
    });

    test('Two instances with different properties should be different',
        () => expect(food1, isNot(equals(food2))));
  });
}
