import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_foods_usecase.dart';

part 'favorite_food_list_event.dart';
part 'favorite_food_list_state.dart';

class FavoriteFoodListBloc
    extends Bloc<FavoriteFoodListEvent, FavoriteFoodListState> {
  FavoriteFoodListBloc() : super(FavoriteFoodListInitialState()) {
    on<FavoriteFoodListGetFoodsEvent>(favoriteFoodListGetFoodsEvent);
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
}
