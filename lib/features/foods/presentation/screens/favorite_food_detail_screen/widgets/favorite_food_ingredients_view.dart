import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FavoriteFoodIngredientsView extends StatelessWidget {
  const FavoriteFoodIngredientsView({
    super.key,
    this.food,
  });

  final FoodEntity? food;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                "⚫️ ${food?.measures![index]} ${food?.ingredients![index]}",
                style: textTheme.bodyMedium,
              ),
            ),
        separatorBuilder: (context, index) => Divider(
              color: Colors.black.withOpacity(0.3),
            ),
        itemCount: food!.ingredients!.length);
  }
}
