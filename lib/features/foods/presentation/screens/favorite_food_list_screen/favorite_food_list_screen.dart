// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_list_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/widgets/error_view.dart';
import 'package:flutter_food_app/features/foods/presentation/widgets/loading_view.dart';

import 'widgets/favorite_food_list_item.dart';

class FavoriteFoodListScreen extends StatelessWidget {
  const FavoriteFoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocConsumer<FavoriteFoodListBloc, FavoriteFoodListState>(
      listener: (context, state) {},
      builder: (context, state) {
        void onRemoveFavorite(String id) async => context
            .read<FavoriteFoodListBloc>()
            .add(FavoriteFoodListRemoveFoodEvent(id));

        if (state is FavoriteFoodListLoadingState) {
          return const LoadingView();
        }

        if (state is FavoriteFoodListGetFoodsErrorState) {
          return ErrorView(
            message: state.message,
          );
        }

        if (state is FavoriteFoodListGetFoodsSuccessState) {
          if (state.foods.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty.png',
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                  Text(
                    "You not have favorite foods",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async => context
                  .read<FavoriteFoodListBloc>()
                  .add(FavoriteFoodListGetFoodsEvent()),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 24),
                  itemCount: state.foods.length,
                  itemBuilder: (context, index) {
                    final food = state.foods[index];
                    return FavoriteFoodListItem(
                      food: food,
                      textTheme: textTheme,
                      onRemoveFavorite: () => onRemoveFavorite(food.id ?? ""),
                    );
                  }),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
