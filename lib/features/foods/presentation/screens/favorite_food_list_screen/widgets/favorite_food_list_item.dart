import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/core/utils/tagify.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:go_router/go_router.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(food.id ?? ""),
        onDismissed: (direction) async => onRemoveFavorite,
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Remove",
                  style: TextStyle(
                      fontSize: textTheme.bodyLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                Icons.delete,
                color: Colors.white,
                size: 24,
              )
            ],
          ),
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
