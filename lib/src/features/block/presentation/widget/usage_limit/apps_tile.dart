import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsTile extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppsTile({
    super.key,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
          Checkbox(
            value: false,
            onChanged: ((value) {}),
          ),
        ],
      ),
    );
  }
}
