import 'package:app_bin_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:app_bin_mobile/src/features/account/signup/presentation/screen/signup_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:app_bin_mobile/src/features/onboarding/on_boarding_screen.dart';
import 'package:app_bin_mobile/src/features/stats/apps_statistics_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case BlockScreen.routeName:
            return const BlockScreen();
          case AppsStatisticsScreen.routeName:
            return const AppsStatisticsScreen();
          case OnBoardingScreen.routeName:
            return const OnBoardingScreen();
          case HomeScreen.routeName:
            return const HomeScreen();
          case LoginScreen.routeName:
            return const LoginScreen();
          case SignUpScreen.routeName:
            return const SignUpScreen();
        }
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Text('no screen'),
          ),
        );
      });
}
