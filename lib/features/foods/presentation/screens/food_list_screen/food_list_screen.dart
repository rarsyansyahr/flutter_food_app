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
                    itemCount: state.foods.length,
                    itemBuilder: (context, index) {
                      final food = state.foods[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
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
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            child: Hero(
              tag: food.thumbnail ?? "",
              child: CachedNetworkImage(
                imageUrl: food.thumbnail ?? "",
                width: double.infinity,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name ?? "",
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${food.category} ${food.tags != null ? "#${food.tags}" : ""}",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.flag_outlined,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          food.area ?? '',
                          style: textTheme.bodyLarge,
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
