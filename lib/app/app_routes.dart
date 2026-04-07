import 'package:app_tp2/screens/debug_screen.dart';
import 'package:app_tp2/screens/pointage_history_screen.dart';
import 'package:app_tp2/screens/pointage_screen.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'package:flutter/material.dart';

Widget buildLoginScreen(BuildContext ctx) => const LoginScreen();
Widget buildHomeScreen(BuildContext ctx) => const HomeScreen();
Widget buildPointageScreen(BuildContext ctx) => const PointageScreen();
Widget buildPointageHistoryScreen(BuildContext ctx) => const PointageHistoryScreen();
Widget buildDebugScreen(BuildContext ctx) => const DebugScreen();

enum AppRoutes {
  loginPage(
    '/login',
    buildLoginScreen
  ),
  homePage(
    '/home',
    buildHomeScreen
  ),
  pointagePage(
    '/pointage',
    buildPointageScreen
  ),
  pointageHistoryPage(
    '/pointage-history',
    buildPointageHistoryScreen
  ),
  debugPage(
    '/debug',
    buildDebugScreen
  );

  final String route;
  final WidgetBuilder builder;

  const AppRoutes(
      this.route,
      this.builder,
      );

  String get path => route;

  static Map<String, WidgetBuilder> getRouteBuilders() {
    return {
      for (final appRoute in AppRoutes.values)
        appRoute.path : appRoute.builder
    };
  }
}