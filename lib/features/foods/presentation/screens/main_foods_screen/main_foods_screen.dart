import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/food_list_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/bloc/main_foods_bloc.dart';
import 'package:flutter_food_app/features/foods/presentation/screens/food_list_screen/food_list_screen.dart';

class BottomMenuItem {
  final String title;
  final IconData activeIcon;
  final IconData inactiveIcon;

  BottomMenuItem(
      {required this.title,
      required this.activeIcon,
      required this.inactiveIcon});
}

class MainFoodsScreen extends StatelessWidget {
  MainFoodsScreen({super.key});

  final List<Widget> _pages = [
    BlocProvider.value(
      value: serviceLocator<FoodListBloc>()..add(FoodListGetFoodsEvent()),
      child: const FoodListScreen(),
    ),
    const Center(
      child: Text("Second Page"),
    )
  ];

  final List<BottomMenuItem> _menus = [
    BottomMenuItem(
        title: "Foods",
        activeIcon: Icons.fastfood,
        inactiveIcon: Icons.fastfood_outlined),
    BottomMenuItem(
        title: "Favorite",
        activeIcon: Icons.favorite,
        inactiveIcon: Icons.favorite_outline)
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainFoodsBloc, MainFoodsState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: _pages[state.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (index) => context
              .read<MainFoodsBloc>()
              .add(MainFoodsPageTappedEvent(index: index)),
          items: _menus.asMap().entries.map((
            entry,
          ) {
            final int index = entry.key;
            final BottomMenuItem menu = entry.value;

            return BottomNavigationBarItem(
                icon: Icon(state.selectedIndex == index
                    ? menu.activeIcon
                    : menu.inactiveIcon),
                label: menu.title);
          }).toList(),
        ),
      ),
    );
  }
}
