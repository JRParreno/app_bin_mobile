import 'package:app_bin_mobile/src/core/bloc/common/common_event.dart';
import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/core/routes/app_route.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:app_bin_mobile/src/features/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBin extends StatefulWidget {
  const AppBin({super.key});

  @override
  State<AppBin> createState() => _AppBinState();
}

class _AppBinState extends State<AppBin> {
  void initialization(BuildContext ctx) async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final userProfile = await ProfileRepositoryImpl().fetchProfile();
      setProfileBloc(profile: userProfile, ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      setProfileBloc(profile: null, ctx: ctx);
    }
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  void setProfileBloc({
    Profile? profile,
    required BuildContext ctx,
  }) {
    if (profile != null) {
      BlocProvider.of<ProfileBloc>(ctx).add(
        SetProfileEvent(profile: profile),
      );
    } else {
      BlocProvider.of<ProfileBloc>(ctx).add(
        const InitialEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ProfileBloc()),
        BlocProvider(create: (ctx) => AppsBloc()),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) {
          initialization(ctx);

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: generateRoute,
                home: state is ProfileLoaded
                    ? const HomeScreen()
                    : const OnBoardingScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
