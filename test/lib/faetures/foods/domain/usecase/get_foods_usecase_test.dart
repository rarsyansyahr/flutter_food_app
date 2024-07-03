import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

void main() {
  late GetFoodsUseCase getFoodsUseCase;
  late MockFoodRepository mockFoodRepository;

  setUp(() {
    mockFoodRepository = MockFoodRepository();
    getFoodsUseCase = GetFoodsUseCase(mockFoodRepository);
  });

  group("Get Foods UseCase Test", () {
    test("Call should return a list of food", () async {
      final foods = [
        const FoodEntity(
            id: "1",
            name: "Mendoan",
            category: "Khas",
            area: "Purbalingga",
            tags: ["Murah", "Meriah", "Mewah"],
            thumbnail: "https://picsum.photos/200",
            measures: ["1pcs"],
            ingredients: ["Egg"],
            instructions: "Buy online"),
        const FoodEntity(
            id: "2",
            name: "Mendoan",
            category: "Khas",
            area: "Purbalingga",
            tags: ["Murah", "Meriah", "Mewah"],
            thumbnail: "https://picsum.photos/200",
            measures: ["1pcs"],
            ingredients: ["Egg"],
            instructions: "Buy online")
      ];

      when(() => mockFoodRepository.getFoods()).thenAnswer((_) async => foods);

      final result = await getFoodsUseCase.call();

      expect(result, equals(foods));

      verify(() => mockFoodRepository.getFoods()).called(1);
      verifyNoMoreInteractions(mockFoodRepository);
    });
  });
}
