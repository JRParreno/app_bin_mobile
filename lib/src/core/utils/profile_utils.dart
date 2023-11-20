import 'package:app_bin_mobile/src/core/bloc/common/common_event.dart';
import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfileUtils {
  static Profile? userProfile(BuildContext ctx) {
    final profileState = BlocProvider.of<ProfileBloc>(ctx).state;
    if (profileState is ProfileLoaded) {
      return profileState.profile;
    }
    return null;
  }

  static void testAdaptiveAlert(BuildContext context) async {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const CustomText(text: AppConstant.appName),
      content: const CustomText(text: "Logout current user?"),
      actions: <Widget>[
        TextButton(
            child: const CustomText(text: "Yes"),
            onPressed: () async {
              await LocalStorage.deleteLocalStorage('_user');
              await LocalStorage.deleteLocalStorage('_device');
              await LocalStorage.deleteLocalStorage(AppConstant.firstLogin);
              Future.delayed(const Duration(milliseconds: 500), () {
                // BlocProvider.of<ProfileBloc>(context)
                //     .add(SetProfileLogoutEvent());
                context.read<ProfileBloc>().add(SetProfileLogoutEvent());
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const OnBoardingScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              });
            }),
        TextButton(
            child: const CustomText(text: "Close"),
            onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }

  static void handleLogout(BuildContext context) async {
    CommonDialog.showMyDialog(
      context: context,
      body: "Logout current user?",
      buttons: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            Navigator.pop(context);
            Future.delayed(const Duration(seconds: 3), () {
              BlocProvider.of<ProfileBloc>(context).add(const InitialEvent());
            });
            // await LocalStorage.deleteLocalStorage('_user');
            // await LocalStorage.deleteLocalStorage('_refreshToken');
            // await LocalStorage.deleteLocalStorage('_token');

            // await Future.delayed(const Duration(microseconds: 300), () {
            //   Navigator.of(context).pop();
            // });
            // Navigator.of(context).popUntil((route) {
            //   return route.settings.name == BlockScreen.routeName;
            // });
            // await Future.delayed(const Duration(milliseconds: 500), () {
            //   Navigator.of(context).pushNamedAndRemoveUntil(
            //     OnBoardingScreen.routeName,
            //     (route) => false,
            //   );
            // });
          },
        ),
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
