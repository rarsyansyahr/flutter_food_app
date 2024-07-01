import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/main_foods_screen/main_foods_screen.dart';

class AppRouter {
  GoRouter generateRoutes() => GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider.value(
            value: serviceLocator<MainFoodsBloc>()
              ..add(MainFoodsGetFoodsEvent()),
            child: const MainFoodsScreen(),
          ),
        )
      ]);
}
