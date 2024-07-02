import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_food_detail_usecase.dart';

part 'food_detail_state.dart';
part 'food_detail_event.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc() : super(FoodDetailInitialState()) {
    on<FoodDetailGetFoodEvent>(foodDetailGetFoodEvent);
  }

  FutureOr<void> foodDetailGetFoodEvent(
      FoodDetailGetFoodEvent event, Emitter<FoodDetailState> emit) async {
    try {
      emit(FoodDetailInitialState());
      FoodEntity food =
          await serviceLocator<GetFoodDetailUseCase>().call(event.id);
      emit(FoodDetailGetFoodSuccessState(food));
    } catch (e) {
      emit(FoodDetailGetFoodErrorState("Error get food"));
    }
  }
}
