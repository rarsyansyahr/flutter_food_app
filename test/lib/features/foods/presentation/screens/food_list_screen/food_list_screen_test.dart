import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/bloc/food_list_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/food_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FoodListBlocMock extends MockBloc<FoodListEvent, FoodListState>
    implements FoodListBloc {}

class GetFoodsUseCaseMock extends Mock implements GetFoodsUseCase {}

void main() {
  group("Food List Screen Test", () {
    late GetFoodsUseCaseMock getFoodsUseCaseMock;
    late FoodListBlocMock foodListBlocMock;
    late List<FoodEntity> foods;

    setUp(() {
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

      getFoodsUseCaseMock = GetFoodsUseCaseMock();
      foodListBlocMock = FoodListBlocMock();

      when(() => getFoodsUseCaseMock.call()).thenAnswer((_) async => foods);
    });

    testWidgets("Render Food List Screen", (tester) async {
      try {
        await tester.pumpWidget(MaterialApp(
          home: BlocProvider(
            create: (_) => FoodListBloc(),
            child: const FoodListScreen(),
          ),
        ));

        await tester.pumpAndSettle();
      } catch (e) {
        print(e);
      }

      // expectLater(actual, matcher)
    });
  });
}
