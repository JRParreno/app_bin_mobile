import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/profile_screen.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_data_repository_impl.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/device_repository_impl.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/apps_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/block_screen.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/widgets/navigation/persistent_bottom_navigation.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/screens/apps_statistics_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  late final AppStatsBloc appStatsBloc;

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final _buildScreens = [
    const AppsScreen(),
    const BlockScreen(),
    const AppsStatisticsScreen(),
    const ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final profile = ProfileUtils.userProfile(context);

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cube_box),
        title: ("Apps"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      if (profile != null && profile.isParent) ...[
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.shield),
          title: ("Blocking"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
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
    appStatsBloc = BlocProvider.of<AppStatsBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => getDeviceInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppStatsBloc, AppStatsState>(
          bloc: appStatsBloc,
          builder: (context, state) {
            return SizedBox(
              child: PersistentBottomNavigation(
                buildScreens: _buildScreens,
                controller: _controller,
                navBarsItems: _navBarsItems(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getDeviceInfo() async {
    EasyLoading.show(status: 'Synching please wait');
    final currentDeviceInfo = await LocalStorage.readLocalStorage('_device');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final String deviceCode = androidInfo.device;
    final String deviceName = androidInfo.model;

    if (currentDeviceInfo == null) {
      final tempDevice =
          await DeviceRepositoryImpl().getUserDevice(deviceCode: deviceCode);

      if (tempDevice != null) {
        await LocalStorage.storeLocalStorage('_device', tempDevice.toJson());
      } else {
        await registerDeviceInfo(
            deviceCode: deviceCode, deviceName: deviceName);
        return;
      }
    }

    await syncAppData(Device.fromJson(currentDeviceInfo));
  }

  Future<void> registerDeviceInfo({
    required String deviceCode,
    required String deviceName,
  }) async {
    final device = await DeviceRepositoryImpl()
        .registerUserDevice(deviceCode: deviceCode, deviceName: deviceName);
    await LocalStorage.storeLocalStorage('_device', device.toJson());

    await syncAppData(device);
  }

  Future<void> syncAppData(Device device) async {
    final apps = await Helper.getListOfApps();

    final dailyUsageApp = await Helper.getDailyAppUsage(apps: apps);

    final today = DateTime.now();

    for (var stats in dailyUsageApp) {
      await AppWeekRepositoryImpl()
          .addAppData(appBinStats: stats, deviceCode: device.deviceCode);
    }

    final syncApps = Helper.convertAppsToDeviceApps(
        apps: apps, deviceId: device.pk.toString());

    await DeviceRepositoryImpl().syncDeviceApps(syncApps);

    final appStats = await AppWeekRepositoryImpl().fetchAppData(
        startDate: Helper.findFirstDateOfTheWeek(today),
        endDate: Helper.findLastDateOfTheWeek(today),
        deviceCode: device.deviceCode);

    appStatsBloc.add(AppStatsInitialUsage(
      appBinStats: Helper.fetchAppDataToAppBinStats(appStats),
      apps: apps,
    ));

    EasyLoading.showSuccess("Done synching");

    await Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
  }
}
