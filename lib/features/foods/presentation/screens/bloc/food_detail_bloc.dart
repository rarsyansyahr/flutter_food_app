import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/add_favorite_food_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_food_detail_usage.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_food_detail_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/remove_favorite_food_usecase.dart';

part 'food_detail_state.dart';
part 'food_detail_event.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc() : super(FoodDetailInitialState()) {
    on<FoodDetailGetFoodEvent>(foodDetailGetFoodEvent);
    on<FoodDetailFavoriteTappedEvent>(foodDetailFavoriteTappedEvent);
  }

  void foodDetailFavoriteTappedEvent(FoodDetailFavoriteTappedEvent event,
      Emitter<FoodDetailState> emit) async {
    try {
      if (event.isFavorite) {
        await serviceLocator<AddFavoriteFoodUsecase>()
            .call(event.isFavorite, event.food);
      } else {
        await serviceLocator<RemoveFavoriteFoodUsecase>()
            .call(event.food.id ?? "");
      }

      if (state is FoodDetailGetFoodSuccessState) {
        final currentState = state as FoodDetailGetFoodSuccessState;

        emit(FoodDetailGetFoodSuccessState(
            food: currentState.food, isFavorite: event.isFavorite));
      }
    } catch (e) {
      emit(FoodDetailGetFoodErrorState("Error add to favorite"));
    }
  }

  FutureOr<void> foodDetailGetFoodEvent(
      FoodDetailGetFoodEvent event, Emitter<FoodDetailState> emit) async {
    try {
      emit(FoodDetailLoadingState());

      FoodEntity food =
          await serviceLocator<GetFoodDetailUseCase>().call(event.id);
      FoodEntity? favoriteFood =
          await serviceLocator<GetFavoriteFoodDetailUsage>()
              .call(food.id ?? "");

      emit(FoodDetailGetFoodSuccessState(
          food: food, isFavorite: favoriteFood != null));
    } catch (e) {
      emit(FoodDetailGetFoodErrorState("Error get food"));
    }
  }
}
