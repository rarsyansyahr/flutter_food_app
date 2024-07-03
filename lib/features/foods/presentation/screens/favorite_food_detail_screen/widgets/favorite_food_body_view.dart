// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';

class FavoriteFoodBodyView extends StatelessWidget {
  const FavoriteFoodBodyView({
    super.key,
    this.food,
    required this.onBackTap,
  });

  final FoodEntity? food;
  final onBackTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: food?.thumbnail ?? "",
            width: double.infinity,
            height: (size.height / 2) + 50,
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
          Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Colors.white,
                    size: 38,
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(2, 1), // changes position of shadow
                      ),
                    ]),
                onPressed: () => onBackTap(),
              )),
        ],
      ),
    );
  }
}
