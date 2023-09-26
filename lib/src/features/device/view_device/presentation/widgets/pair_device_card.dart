import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:flutter/material.dart';

class PairDeviceCard extends StatelessWidget {
  const PairDeviceCard({
    super.key,
    required this.pairDevice,
  });

  final PairDevice pairDevice;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: pairDevice.profilePhoto != null
                      ? NetworkImage(pairDevice.profilePhoto!)
                      : null,
                  radius: 25,
                  child: pairDevice.profilePhoto != null
                      ? null
                      : const Icon(Icons.person, size: 25),
                ),
                const SizedBox(
                  width: 15,
                ),
                CustomText(
                  text: pairDevice.fullName,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Badge(
              label: CustomText(text: pairDevice.pairStatus.toLowerCase()),
              backgroundColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
