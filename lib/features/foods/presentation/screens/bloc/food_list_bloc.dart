import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';

part 'food_list_event.dart';
part 'food_list_state.dart';

class FoodListBloc extends Bloc<FoodListEvent, FoodListState> {
  FoodListBloc() : super(FoodListInitialState()) {
    on<FoodListGetFoodsEvent>(foodListGetFoodsEvent);
  }

  FutureOr<void> foodListGetFoodsEvent(
      FoodListGetFoodsEvent event, Emitter<FoodListState> emit) async {
    try {
      emit(FoodListLoadingState());
      List<FoodEntity> foods = await serviceLocator<GetFoodsUseCase>().call();
      emit(FoodListGetFoodsSuccessState(foods: foods, favoriteFoods: foods));
    } catch (e) {
      emit(FoodListGetFoodsErrorState("Error get foods"));
    }
  }
}
