import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:flutter/material.dart';

class BlockDevice extends StatelessWidget {
  const BlockDevice({super.key, required this.device, required this.onTap});

  final Device device;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.device_hub),
          title: CustomText(text: device.deviceName),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
