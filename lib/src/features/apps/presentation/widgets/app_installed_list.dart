import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_installed_tile.dart';
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
      padding: const EdgeInsets.all(15.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: MediaQuery.of(context).size.width * 0.04,
        runSpacing: 4,
        direction: Axis.horizontal,
        children: [
          for (var app in apps)
            AppInstalledTile(
              app: app as ApplicationWithIcon,
            ),
        ],
      ),
    );
  }
}
