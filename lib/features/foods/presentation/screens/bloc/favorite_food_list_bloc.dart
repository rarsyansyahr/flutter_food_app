import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_foods_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/remove_favorite_food_usecase.dart';

part 'favorite_food_list_event.dart';
part 'favorite_food_list_state.dart';

class FavoriteFoodListBloc
    extends Bloc<FavoriteFoodListEvent, FavoriteFoodListState> {
  FavoriteFoodListBloc() : super(FavoriteFoodListInitialState()) {
    on<FavoriteFoodListGetFoodsEvent>(favoriteFoodListGetFoodsEvent);

    on<FavoriteFoodListRemoveFoodEvent>(favoriteFoodListRemoveFoodEvent);
  }

  FutureOr<void> favoriteFoodListGetFoodsEvent(
      FavoriteFoodListGetFoodsEvent event,
      Emitter<FavoriteFoodListState> emit) async {
    try {
      emit(FavoriteFoodListLoadingState());
      List<FoodEntity> foods =
          await serviceLocator<GetFavoriteFoodsUsecase>().call();
      emit(FavoriteFoodListGetFoodsSuccessState(foods));
    } catch (e) {
      emit(FavoriteFoodListGetFoodsErrorState("Error get favorite foods"));
    }
  }

  FutureOr<void> favoriteFoodListRemoveFoodEvent(
      FavoriteFoodListRemoveFoodEvent event,
      Emitter<FavoriteFoodListState> emit) async {
    try {
      await serviceLocator<RemoveFavoriteFoodUsecase>().call(event.id);

      if (state is FavoriteFoodListGetFoodsSuccessState) {
        final currentState = state as FavoriteFoodListGetFoodsSuccessState;
        currentState.foods.removeWhere((food) => food.id == event.id);
        emit(FavoriteFoodListGetFoodsSuccessState(currentState.foods));
      }
    } catch (e) {
      emit(FavoriteFoodListGetFoodsErrorState("Error remove favorite food"));
    }
  }
}
