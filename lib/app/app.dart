import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';
import '../theme/app_theme.dart';
import 'app_routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = ThemeController.instance;

  @override
  Widget build(BuildContext ctx) {
    return AnimatedBuilder(
        animation: themeController,
        builder: (ctx, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode,
            initialRoute: AppRoutes.loginPage.path,
            routes: AppRoutes.getRouteBuilders()
          );
        }
    );
  }
}