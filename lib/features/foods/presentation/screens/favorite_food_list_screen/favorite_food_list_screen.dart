// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_list_bloc.dart';

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
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoriteFoodListGetFoodsErrorState) {
          return Center(
              child: Text(state.message, textAlign: TextAlign.center));
        }

        if (state is FavoriteFoodListGetFoodsSuccessState) {
          if (state.foods.isEmpty) {
            return const Center(
              child: Text("You not have favorite foods"),
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
