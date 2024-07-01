import 'package:flutter/material.dart';
import 'package:flutter_food_app/features/app/app.dart';
import 'package:flutter_food_app/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MainApp());
}
