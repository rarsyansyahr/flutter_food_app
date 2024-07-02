import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_detail_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<FoodDetailBloc, FoodDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FoodDetailLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FoodDetailGetFoodErrorState) {
          return Center(
              child: Text(state.message, textAlign: TextAlign.center));
        }

        if (state is FoodDetailGetFoodSuccessState) {
          return Scaffold(
              body: SlidingUpPanel(
            parallaxEnabled: true,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            minHeight: (size.height / 2),
            maxHeight: (size.height / 1.2),
            panel: _panel(textTheme, state.food),
            body: _body(size, state.food, state.isFavorite, () {
              context.read<FoodDetailBloc>().add(
                  FoodDetailFavoriteTappedEvent(isFavorite: !state.isFavorite));
            }),
          ));
        }

        return const SizedBox();
      },
    );
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
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name ?? "",
                        style: textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
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
                      _ingredients(food),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(food.instructions ?? ""))
                    ],
                  ))
                ],
              ),
            ))
          ],
        ),
      );

  Widget _body(Size size, FoodEntity food, bool isFavorite, onFavoriteTap) =>
      SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
                tag: food.thumbnail ?? "",
                child: CachedNetworkImage(
                  imageUrl: food.thumbnail ?? "",
                  width: double.infinity,
                  height: (size.height / 2) + 50,
                  fit: BoxFit.cover,
                )),
            Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 38,
                  ),
                  onPressed: () {},
                )),
            Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 38,
                  ),
                  onPressed: () => onFavoriteTap(),
                ))
          ],
        ),
      );

  Widget _ingredients(FoodEntity food) => ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child:
                Text("⚫️ ${food.measures![index]} ${food.ingredients![index]}"),
          ),
      separatorBuilder: (context, index) => Divider(
            color: Colors.black.withOpacity(0.3),
          ),
      itemCount: food.ingredients!.length);
}
