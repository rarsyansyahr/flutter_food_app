import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

import 'router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    FlutterSplashScreen.hide();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().generateRoutes(),
      theme: ThemeData(
          textTheme: Platform.isIOS
              ? GoogleFonts.poppinsTextTheme(textTheme)
              : GoogleFonts.openSansTextTheme(textTheme)),
    );
  }
}
