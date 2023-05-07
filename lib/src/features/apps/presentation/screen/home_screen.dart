import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_installed_list.dart';
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

  void getListOfApps() async {
    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    setState(() {
      myApps = tempList
          .where((element) =>
              element.category == ApplicationCategory.game ||
              element.category == ApplicationCategory.social)
          .toList();
    });
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
        title: const Text("Home Screen"),
      ),
      body: SizedBox(
          child: myApps.isNotEmpty
              ? AppInstalledList(
                  apps: myApps,
                )
              : const Center(child: CircularProgressIndicator())),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppsStatisticsScreen.routeName,
            arguments: AppsStatisticsScreenArgs(myApps: myApps),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
