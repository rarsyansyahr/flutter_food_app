import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_detail_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_detail_screen/food_detail_screen.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/main_foods_screen/main_foods_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_list_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/food_list_screen.dart';

class AppRouter {
  GoRouter generateRoutes() => GoRouter(routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => BlocProvider.value(
            value: serviceLocator<MainFoodsBloc>(),
            child: MainFoodsScreen(),
          ),
        ),
        GoRoute(
          path: '/food-list',
          name: 'food_list',
          builder: (context, state) => BlocProvider.value(
            value: serviceLocator<FoodListBloc>()..add(FoodListGetFoodsEvent()),
            child: const FoodListScreen(),
          ),
        ),
        GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) {
            final String id = state.extra as String;

            return BlocProvider.value(
              value: serviceLocator<FoodDetailBloc>()
                ..add(FoodDetailGetFoodEvent(id)),
              child: const FoodDetailScreen(),
            );
          },
        )
      ]);
}
