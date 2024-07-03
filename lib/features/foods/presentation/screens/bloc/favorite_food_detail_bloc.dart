import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_food_detail_usage.dart';

part 'favorite_food_detail_state.dart';
part 'favorite_food_detail_event.dart';

class FavoriteFoodDetailBloc
    extends Bloc<FavoriteFoodDetailEvent, FavoriteFoodDetailState> {
  FavoriteFoodDetailBloc() : super(FavoriteFoodDetailInitialState()) {
    on<FavoriteFoodDetailGetFoodEvent>(favoriteFoodDetailGetFoodEvent);
  }

  FutureOr<void> favoriteFoodDetailGetFoodEvent(
      FavoriteFoodDetailGetFoodEvent event,
      Emitter<FavoriteFoodDetailState> emit) async {
    try {
      emit(FavoriteFoodDetailLoadingState());
      FoodEntity? food =
          await serviceLocator<GetFavoriteFoodDetailUsage>().call(event.id);
      emit(FavoriteFoodDetailGetFoodSuccessState(food: food));
    } catch (e, s) {
      emit(FavoriteFoodDetailGetFoodErrorState("Error get food"));
    }
  }
}
