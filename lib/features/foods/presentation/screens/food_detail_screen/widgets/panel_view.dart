import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/core/utils/tagify.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

import 'ingredients_view.dart';

class PanelView extends StatelessWidget {
  const PanelView({
    super.key,
    required this.food,
  });

  final FoodEntity food;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
                          fontSize: textTheme.headlineMedium!.fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      food.category ?? "",
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      serviceLocator<Tagify>()
                          .createTags(values: food.tags ?? []),
                      style: textTheme.bodySmall,
                    )
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
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black.withOpacity(0.3),
          ),
          Expanded(
              child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: "Ingredients".toUpperCase(),
                    ),
                    Tab(
                      text: "Instructions".toUpperCase(),
                    )
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(0.3),
                  labelStyle: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 32),
                  dividerColor: Colors.transparent,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    IngredientsView(food: food),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        food.instructions ?? "",
                        style: textTheme.bodyMedium,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
