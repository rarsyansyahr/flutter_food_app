part of 'main_foods_bloc.dart';

class MainFoodsState extends Equatable {
  final int selectedIndex;

  const MainFoodsState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
