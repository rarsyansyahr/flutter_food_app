import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_food_detail_usage.dart';

part 'favorite_food_detail_event.dart';
part 'favorite_food_detail_state.dart';

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
      final FoodEntity? food =
          await serviceLocator<GetFavoriteFoodDetailUsage>().call(event.id);
      emit(FavoriteFoodDetailGetFoodSuccessState(food!));
    } catch (e) {
      emit(FavoriteFoodDetailGetFoodErrorState("Error get food"));
    }
  }
}
