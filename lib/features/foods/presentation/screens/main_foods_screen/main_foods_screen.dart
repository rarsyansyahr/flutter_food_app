import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';

class MainFoodsScreen extends StatelessWidget {
  const MainFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainFoodsBloc, MainFoodsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MainFoodsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MainFoodsGetFoodsErrorState) {
            return Center(
                child: Text(state.message, textAlign: TextAlign.center));
          }

          if (state is MainFoodsGetFoodsSuccessState) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Foods Screen"),
                ),
                body: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.foods.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: state.foods[index].thumbnail ?? "",
                            width: 100,
                            height: 100,
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
                          title: Text(state.foods[index].name ?? "-"),
                        )));
          }

          return const SizedBox();
        });
  }
}