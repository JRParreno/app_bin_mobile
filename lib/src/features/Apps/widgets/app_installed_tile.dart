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
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.memory(
            app.icon,
            height: 40,
            width: 40,
          ),
        ),
        Text(app.appName),
        const Divider(
          color: Colors.amber,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
