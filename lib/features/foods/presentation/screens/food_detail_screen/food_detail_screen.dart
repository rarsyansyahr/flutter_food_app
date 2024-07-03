import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_detail_bloc.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'widgets/body_view.dart';
import 'widgets/panel_view.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    void onFavoriteTap(bool isFavorite, FoodEntity food) => context
        .read<FoodDetailBloc>()
        .add(FoodDetailFavoriteTappedEvent(isFavorite: isFavorite, food: food));

    return BlocConsumer<FoodDetailBloc, FoodDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FoodDetailLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FoodDetailGetFoodErrorState) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text(state.message, textAlign: TextAlign.center),
              ));
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
            panel: PanelView(food: state.food),
            body: BodyView(
                food: state.food,
                isFavorite: state.isFavorite,
                onFavoriteTap: () =>
                    onFavoriteTap(!state.isFavorite, state.food)),
          ));
        }

        return const SizedBox();
      },
    );
  }
}
