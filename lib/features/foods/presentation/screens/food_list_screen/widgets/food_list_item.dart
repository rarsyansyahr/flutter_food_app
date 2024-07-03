import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/core/utils/tagify.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({
    super.key,
    required this.food,
  });

  final FoodEntity food;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Ink(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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
                        style: TextStyle(
                            fontSize: textTheme.titleLarge!.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${food.category} ${serviceLocator<Tagify>().createTags(values: food.tags ?? [], max: 1)}",
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
