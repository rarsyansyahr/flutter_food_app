import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_list_bloc.dart';
import 'package:go_router/go_router.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<FoodListBloc, FoodListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FoodListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FoodListGetFoodsErrorState) {
            return Center(
                child: Text(state.message, textAlign: TextAlign.center));
          }

          if (state is FoodListGetFoodsSuccessState) {
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async =>
                    context.read<FoodListBloc>().add(FoodListGetFoodsEvent()),
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 24),
                    shrinkWrap: true,
                    itemCount: state.foods.length,
                    itemBuilder: (context, index) {
                      final food = state.foods[index];

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () =>
                              context.goNamed("detail", extra: food.id),
                          child: _listItem(textTheme, food),
                        ),
                      );
                    }),
              ),
            );
          }

          return const SizedBox();
        });
  }

  Widget _listItem(TextTheme textTheme, FoodEntity food) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Hero(
            tag: food.thumbnail ?? "",
            child: CachedNetworkImage(
              imageUrl: food.thumbnail ?? "",
              width: 320,
              height: 320,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Text(
                  "No Image",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name ?? "",
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      food.category ?? "",
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.flag_outlined),
                      Text(
                        food.area ?? '',
                        style: textTheme.bodySmall,
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}
