import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/favorite_food_detail_screen/bloc/favorite_food_detail_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/favorite_food_detail_screen/widgets/favorite_food_body_view.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/favorite_food_detail_screen/widgets/favorite_food_panel_view.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/widgets/error_view.dart';
import 'package:flutter_food_app/features/foods/presentation/widgets/loading_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FavoriteFoodDetailScreen extends StatelessWidget {
  const FavoriteFoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    void onBackTap() => context.pop();

    return BlocConsumer<FavoriteFoodDetailBloc, FavoriteFoodDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavoriteFoodDetailLoadingState) {
            return const Scaffold(
              body: Center(
                child: LoadingView(),
              ),
            );
          }

          if (state is FavoriteFoodDetailGetFoodErrorState) {
            return Scaffold(
                body: ErrorView(
              message: state.message,
            ));
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
              panel: FavoriteFoodPanelView(food: state.food),
              body:
                  FavoriteFoodBodyView(food: state.food, onBackTap: onBackTap),
            ));
          }

          return const SizedBox();
        });
  }
}
