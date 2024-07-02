import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_detail_bloc.dart';

// class FoodDetailScreen extends StatelessWidget {
//   const FoodDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text("Content"),
//       ),
//     );
//   }
// }

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodDetailBloc, FoodDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FoodDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FoodDetailGetFoodErrorState) {
          return Center(
              child: Text(state.message, textAlign: TextAlign.center));
        }

        if (state is FoodDetailGetFoodSuccessState) {
          return Scaffold(
              body: ListView(
            children: [Text(state.food.toString())],
          ));
        }

        return const SizedBox();
      },
    );
  }
}
