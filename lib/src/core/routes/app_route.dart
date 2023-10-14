import 'package:app_bin_mobile/src/features/account/forgot_password/presentation/screen/forgot_password_screen.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/change_password_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/update_profile_picture_screen.dart';
import 'package:app_bin_mobile/src/features/account/signup/presentation/screen/signup_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/apps_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/add_block_app_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/add_usage_limit_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/prompt_block_screen.dart';
import 'package:app_bin_mobile/src/features/device/add_device/presentation/screen/add_device_screen.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/screen/view_device_screen.dart';
import 'package:app_bin_mobile/src/features/onboarding/on_boarding_screen.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/screens/apps_statistics_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        switch (settings.name) {
          case AppsScreen.routeName:
            return const AppsScreen();
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
          case ProfileScreen.routeName:
            return const ProfileScreen();
          case AddUsageLimitScreen.routeName:
            return const AddUsageLimitScreen();
          case PromptBlockScreen.routeName:
            final args = settings.arguments! as PromptBlockArgs;
            return PromptBlockScreen(
              args: args,
            );
          case ViewDeviceScreen.routeName:
            return const ViewDeviceScreen();
          case ChangePasswordScreen.routeName:
            return const ChangePasswordScreen();
          case UpdateAccountScreen.routeName:
            return const UpdateAccountScreen();
          case UpdateProfilePcitureScreen.routeName:
            return const UpdateProfilePcitureScreen();
          case AddBlockAppScreen.routeName:
            return const AddBlockAppScreen();
          case AddDeviceScreen.routeName:
            return const AddDeviceScreen();
          case ForgotPasswordScreen.routeName:
            return const ForgotPasswordScreen();
        }
        return const Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Text('no screen'),
          ),
        );
      });
}
