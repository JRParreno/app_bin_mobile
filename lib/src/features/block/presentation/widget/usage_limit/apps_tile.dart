import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsTile extends StatelessWidget {
  final ApplicationWithIcon app;
  final bool isBlock;
  final Function(bool value) isOnchanged;

  const AppsTile({
    super.key,
    required this.app,
    required this.isOnchanged,
    this.isBlock = false,
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
            value: isBlock,
            onChanged: ((value) {
              isOnchanged(value ?? false);
            }),
          ),
        ],
      ),
    );
  }
}
