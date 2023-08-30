import 'package:app_bin_mobile/src/core/bloc/common/common_event.dart';
import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
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
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
      final whiteList = await LocalStorage.readLocalStorage('_whiteList');

      final userProfile = await ProfileRepositoryImpl().fetchProfile();
      // ignore: use_build_context_synchronously
      setProfileBloc(profile: userProfile, ctx: ctx);
      // ignore: use_build_context_synchronously
      setWhiteList(whiteList: whiteList.toString().split(', '), ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      await LocalStorage.deleteLocalStorage('_whiteList');
      // ignore: use_build_context_synchronously
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

  void setWhiteList({
    required List<String> whiteList,
    required BuildContext ctx,
  }) {
    BlocProvider.of<AppsBloc>(ctx).add(AppsLoadInitEvent(whiteList: whiteList));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ProfileBloc()),
        BlocProvider(create: (ctx) => AppsBloc()),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: EasyLoading.init(),
            onGenerateRoute: generateRoute,
            home: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (ctx, state) {
                if (state is InitialState) {
                  initialization(ctx);
                }

                if (state is ProfileLoaded) {
                  return const HomeScreen();
                } else {
                  return const OnBoardingScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
