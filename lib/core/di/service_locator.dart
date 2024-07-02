import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/utils/split_food_fields_util.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_food_detail_usecase.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_detail_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_food_app/core/network/network_client.dart';
import 'package:flutter_food_app/core/shared/constants.dart';
import 'package:flutter_food_app/features/foods/data/api/food_api.dart';
import 'package:flutter_food_app/features/foods/data/repository/food_repository_impl.dart';
import 'package:flutter_food_app/features/foods/domain/repository/food_repository.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_foods_usecase.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_list_bloc.dart';

final serviceLocator = GetIt.instance;

setupServiceLocator() async {
  serviceLocator.registerFactory<Constant>(() => Constant());
  serviceLocator
      .registerFactory<SplitFoodFieldsUtil>(() => SplitFoodFieldsUtil());
  serviceLocator.registerFactory<Dio>(
      () => NetworkClient(Dio(), constant: serviceLocator()).dio);

  // * Main Foods
  serviceLocator.registerLazySingleton<FoodApi>(() =>
      FoodApi(dio: serviceLocator(), splitFoodFieldsUtil: serviceLocator()));
  serviceLocator.registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(foodApi: serviceLocator()));

  serviceLocator.registerFactory<MainFoodsBloc>(() => MainFoodsBloc());

  // * Food List
  serviceLocator.registerFactory<FoodListBloc>(() => FoodListBloc());
  serviceLocator.registerLazySingleton<GetFoodsUseCase>(
      () => GetFoodsUseCase(serviceLocator()));

  // * Food Detail
  serviceLocator.registerFactory<FoodDetailBloc>(() => FoodDetailBloc());
  serviceLocator.registerLazySingleton<GetFoodDetailUseCase>(
      () => GetFoodDetailUseCase(serviceLocator()));
}
