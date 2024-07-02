import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_list_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoriteFoodListScreen extends StatelessWidget {
  const FavoriteFoodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteFoodListBloc, FavoriteFoodListState>(
      listener: (context, state) {},
      builder: (context, state) {
        final TextTheme textTheme = Theme.of(context).textTheme;

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
                  padding: const EdgeInsets.only(top: 24),
                  itemCount: state.foods.length,
                  itemBuilder: (context, index) {
                    final food = state.foods[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(food.id ?? ""),
                        onDismissed: (direction) {},
                        background: Container(
                          color: Colors.red,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () =>
                              context.goNamed("detail", extra: food.id),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
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
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
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
                                  width: 12,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.name ?? "",
                                        style: textTheme.titleMedium,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${food.category} ${food.tags != null ? "#${food.tags}" : ""}",
                                        style: textTheme.bodySmall,
                                      ),
                                      const SizedBox(
                                        height: 8,
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
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
