import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';

part 'main_foods_event.dart';
part 'main_foods_state.dart';

class MainFoodsBloc extends Bloc<MainFoodsEvent, MainFoodsState> {
  MainFoodsBloc() : super(MainFoodsInitialState()) {
    on<MainFoodsGetFoodsEvent>(mainFoodsGetFoodsEvent);
  }

  FutureOr<void> mainFoodsGetFoodsEvent(
      MainFoodsGetFoodsEvent event, Emitter<MainFoodsState> emit) async {
    try {
      emit(MainFoodsLoadingState());
      List<FoodEntity> foods = await serviceLocator<GetFoodsUseCase>().call();
      emit(MainFoodsGetFoodsSuccessState(foods));
    } catch (e) {
      emit(MainFoodsGetFoodsErrorState("Error get foods"));
    }
  }
}
