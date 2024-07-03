import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/bloc/food_list_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/widgets/error_view.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/widgets/food_list_item.dart';
import 'package:flutter_food_app/features/foods/presentation/widgets/loading_view.dart';
import 'package:go_router/go_router.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodListBloc, FoodListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FoodListLoadingState) {
            return const LoadingView();
          }

          if (state is FoodListGetFoodsErrorState) {
            return ErrorView(
              message: state.message,
            );
          }

          if (state is FoodListGetFoodsSuccessState) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<FoodListBloc>().add(FoodListGetFoodsEvent()),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 36),
                  itemCount: state.foods.length,
                  itemBuilder: (context, index) {
                    final food = state.foods[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => context.goNamed("detail", extra: food.id),
                        child: FoodListItem(food: food),
                      ),
                    );
                  }),
            );
          }

          return const SizedBox();
        });
  }
}
