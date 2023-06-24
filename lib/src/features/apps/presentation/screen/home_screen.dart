import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/apps_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/navigation/persistent_bottom_navigation.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/screens/apps_statistics_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Application> myApps = [];
  int currentTab = 0;

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  Future<List<Application>> getListOfApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    setState(() {
      myApps = tempList
          .where((element) =>
              element.category == ApplicationCategory.game ||
              element.category == ApplicationCategory.social ||
              element.category == ApplicationCategory.productivity)
          .toList();
    });

    return tempList
        .where((element) =>
            element.category == ApplicationCategory.game ||
            element.category == ApplicationCategory.social ||
            element.category == ApplicationCategory.productivity)
        .toList();
  }

  final _buildScreens = [
    const AppsScreen(),
    const BlockScreen(),
    const AppsStatisticsScreen(),
    const ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cube_box),
        title: ("Apps"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.shield),
        title: ("Blocking"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chart_bar),
        title: ("Statistics"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    getListOfApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AppStatsBloc()
            ..add(AppStatsCurrentUsage(
              startTime: DateTime.now(),
              endTime: DateTime.now(),
            )),
          child: SizedBox(
            child: PersistentBottomNavigation(
              buildScreens: _buildScreens,
              controller: _controller,
              navBarsItems: _navBarsItems(),
            ),
          ),
        ),
      ),
    );
  }
}
