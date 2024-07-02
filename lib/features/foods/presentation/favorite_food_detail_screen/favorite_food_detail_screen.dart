import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/core/utils/tagify.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/favorite_food_detail_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FavoriteFoodDetailScreen extends StatelessWidget {
  const FavoriteFoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    void onBackTap() => context.pop();

    return BlocConsumer<FavoriteFoodDetailBloc, FavoriteFoodDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavoriteFoodDetailLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is FavoriteFoodDetailGetFoodErrorState) {
            return const Scaffold(
              body: Center(
                child: Text("Error get food"),
              ),
            );
          }

          if (state is FavoriteFoodDetailGetFoodSuccessState) {
            return Scaffold(
                body: SlidingUpPanel(
              parallaxEnabled: true,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minHeight: size.height / 2,
              maxHeight: size.height / 1.2,
              panel: _panel(textTheme, state.food),
              body: _body(size, state.food, onBackTap),
            ));
          }

          return const SizedBox();
        });
  }

  Widget _panel(TextTheme textTheme, FoodEntity food) => Padding(
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
                      _ingredients(textTheme, food),
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

  Widget _body(Size size, FoodEntity food, onBackTap) => SingleChildScrollView(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: food.thumbnail ?? "",
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

  Widget _ingredients(TextTheme textTheme, FoodEntity food) =>
      ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  "⚫️ ${food.measures![index]} ${food.ingredients![index]}",
                  style: textTheme.bodyMedium,
                ),
              ),
          separatorBuilder: (context, index) => Divider(
                color: Colors.black.withOpacity(0.3),
              ),
          itemCount: food.ingredients!.length);
}
