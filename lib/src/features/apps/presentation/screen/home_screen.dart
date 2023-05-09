import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/navigation/bottom_navigation.dart';
import 'package:app_bin_mobile/src/features/stats/apps_statistics_screen.dart';
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

  Future<List<Application>> getListOfApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    setState(() {
      myApps = tempList
          .where((element) =>
              element.category == ApplicationCategory.game ||
              element.category == ApplicationCategory.social)
          .toList();
    });

    return tempList
        .where((element) =>
            element.category == ApplicationCategory.game ||
            element.category == ApplicationCategory.social)
        .toList();
  }

  final screens = [
    const BlockScreen(),
    const AppsStatisticsScreen(),
    const ProfileScreen(),
  ];

  String handleTitleAppBar() {
    switch (currentTab) {
      case 0:
        return AppConstant.appName;
      case 1:
        return "Statistics";
      case 2:
        return "Profile";
      default:
        return "";
    }
  }

  @override
  void initState() {
    getListOfApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(handleTitleAppBar()),
        backgroundColor: ColorName.primary,
      ),
      body: SizedBox(
        child: screens[currentTab],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProfileUtils.handleLogout(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.logout),
      ),
      bottomNavigationBar: BottomNavigation(
        onTap: (value) {
          if (currentTab != value) {
            setState(() {
              currentTab = value;
            });
          }
        },
        selectedIndex: currentTab,
      ),
    );
  }
}
