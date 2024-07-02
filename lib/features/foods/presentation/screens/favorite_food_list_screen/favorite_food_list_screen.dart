// ignore_for_file: void_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/core/utils/tagify.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_list_bloc.dart';
import 'package:go_router/go_router.dart';

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

class FavoriteFoodListItem extends StatelessWidget {
  const FavoriteFoodListItem(
      {super.key,
      required this.food,
      required this.textTheme,
      required this.onRemoveFavorite});

  final FoodEntity food;
  final TextTheme textTheme;
  final void onRemoveFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(food.id ?? ""),
        onDismissed: (direction) async => onRemoveFavorite,
        background: Container(
          decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.goNamed("favorite_detail", extra: food.id),
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: food.thumbnail ?? "",
                      width: double.infinity,
                      height: 120,
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
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name ?? "",
                          style: TextStyle(
                              fontSize: textTheme.titleMedium!.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${food.category} ${serviceLocator<Tagify>().createTags(values: food.tags ?? [], max: 1)}",
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.flag_outlined,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              food.area ?? '',
                              style: textTheme.bodyMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
