import 'package:app_bin_mobile/src/core/bloc/common/common_event.dart';
import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_dialog.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUtils {
  static Profile? userProfile(BuildContext ctx) {
    final profileState = BlocProvider.of<ProfileBloc>(ctx).state;
    if (profileState is ProfileLoaded) {
      return profileState.profile;
    }
    return null;
  }

  static void handleLogout(BuildContext context) async {
    CommonDialog.showMyDialog(
      context: context,
      body: "Logout current user?",
      buttons: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            BlocProvider.of<ProfileBloc>(context).add(const InitialEvent());
            await LocalStorage.deleteLocalStorage('_user');
            await LocalStorage.deleteLocalStorage('_refreshToken');
            await LocalStorage.deleteLocalStorage('_token');

            // await Future.delayed(const Duration(microseconds: 300), () {
            //   Navigator.of(context).pop();
            // });
            await Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                OnBoardingScreen.routeName,
                (route) => false,
              );
            });
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
