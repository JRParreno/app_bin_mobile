import 'package:app_bin_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:app_bin_mobile/src/features/stats/apps_statistics_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (context) {
    switch (settings.name) {
      case AppsStatisticsScreen.routeName:
        final args = settings.arguments! as AppsStatisticsScreenArgs;
        return AppsStatisticsScreen(args: args);
      case HomeScreen.routeName:
        return const HomeScreen();
      case LoginScreen.routeName:
        return const LoginScreen();
    }
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text('no screen'),
      ),
    );
  });
}
