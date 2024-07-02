import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/utils/split_food_fields_util.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_food_app/core/network/network_client.dart';
import 'package:flutter_food_app/core/shared/constants.dart';
import 'package:flutter_food_app/features/foods/data/api/food_api.dart';
import 'package:flutter_food_app/features/foods/data/repository/food_repository_impl.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';

final serviceLocator = GetIt.instance;

setupServiceLocator() async {
  serviceLocator.registerFactory<Constant>(() => Constant());
  serviceLocator
      .registerFactory<SplitFoodFieldsUtil>(() => SplitFoodFieldsUtil());
  serviceLocator.registerFactory<Dio>(
      () => NetworkClient(Dio(), constant: serviceLocator()).dio);

  // * Foods
  serviceLocator.registerFactory<MainFoodsBloc>(() => MainFoodsBloc());
  serviceLocator.registerLazySingleton<FoodApi>(() =>
      FoodApi(dio: serviceLocator(), splitFoodFieldsUtil: serviceLocator()));
  serviceLocator.registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(foodApi: serviceLocator()));
  serviceLocator.registerLazySingleton<GetFoodsUseCase>(
      () => GetFoodsUseCase(serviceLocator()));
}
