import 'package:flutter_food_app/features/foods/data/api/food_api.dart';
import 'package:flutter_food_app/features/foods/data/database/food_database.dart';
import 'package:flutter_food_app/features/foods/data/repository/food_repository_impl.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFoodApi extends Mock implements FoodApi {}

class MockFoodDatabaseProvider extends Mock implements FoodDatabaseProvider {}

void main() {
  late FoodRepositoryImpl foodRepository;
  late MockFoodApi mockFoodApi;
  late MockFoodDatabaseProvider mockFoodDatabaseProvider;
  late List<FoodEntity> foods;

  setUp(() {
    mockFoodApi = MockFoodApi();
    mockFoodDatabaseProvider = MockFoodDatabaseProvider();
    foodRepository = FoodRepositoryImpl(
        foodApi: mockFoodApi, foodDatabaseProvider: mockFoodDatabaseProvider);
    foods = [
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
  });

  group("Food Repository Test", () {
    test("Get Foods from API", () async {
      when(() => mockFoodApi.getFoods()).thenAnswer((_) async => foods);

      final result = await foodRepository.getFoods();

      expect(result, equals(foods));

      verify(() => mockFoodApi.getFoods()).called(1);
      verifyNoMoreInteractions(mockFoodApi);
    });
  });
}
