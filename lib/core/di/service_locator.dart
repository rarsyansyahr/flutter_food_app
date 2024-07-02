import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/utils/split_food_fields_util.dart';
import 'package:flutter_food_app/features/foods/data/database/food_database.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/add_favorite_food_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_food_detail_usage.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_favorite_foods_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/get_food_detail_usecase.dart';
import 'package:flutter_food_app/features/foods/domain/usecase/remove_favorite_food_usecase.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_list_bloc.dart';
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

  // * Foods
  serviceLocator.registerLazySingleton<FoodApi>(() =>
      FoodApi(dio: serviceLocator(), splitFoodFieldsUtil: serviceLocator()));
  serviceLocator.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(
      foodApi: serviceLocator(), foodDatabaseProvider: serviceLocator()));

  // * Main Foods
  serviceLocator.registerFactory<MainFoodsBloc>(() => MainFoodsBloc());
  serviceLocator.registerLazySingleton<FoodDatabaseProvider>(
      () => FoodDatabaseProvider());

  // * Food List
  serviceLocator.registerFactory<FoodListBloc>(() => FoodListBloc());
  serviceLocator.registerLazySingleton<GetFoodsUseCase>(
      () => GetFoodsUseCase(serviceLocator()));

  // * Food Detail
  serviceLocator.registerFactory<FoodDetailBloc>(() => FoodDetailBloc());
  serviceLocator.registerLazySingleton<GetFoodDetailUseCase>(
      () => GetFoodDetailUseCase(serviceLocator()));

  // * Favorite Food List
  serviceLocator
      .registerFactory<FavoriteFoodListBloc>(() => FavoriteFoodListBloc());
  serviceLocator.registerLazySingleton<GetFavoriteFoodsUsecase>(
      () => GetFavoriteFoodsUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<AddFavoriteFoodUsecase>(
      () => AddFavoriteFoodUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<GetFavoriteFoodDetailUsage>(
      () => GetFavoriteFoodDetailUsage(serviceLocator()));
  serviceLocator.registerLazySingleton<RemoveFavoriteFoodUsecase>(
      () => RemoveFavoriteFoodUsecase(serviceLocator()));
}
