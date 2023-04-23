import 'package:app_bin_mobile/src/features/apps/widgets/app_installed_tile.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppInstalledList extends StatelessWidget {
  final List<Application> apps;

  const AppInstalledList({
    super.key,
    required this.apps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: apps.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return AppInstalledTile(
              app: apps[index] as ApplicationWithIcon,
            );
          }),
    );
  }
}
