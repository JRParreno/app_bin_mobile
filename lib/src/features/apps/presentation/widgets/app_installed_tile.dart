import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppInstalledTile extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppInstalledTile({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.memory(
              app.icon,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(app.appName, maxLines: 1),
          const Divider(
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
