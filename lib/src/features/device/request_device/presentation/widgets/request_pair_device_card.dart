import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class RequestPairDeviceCard extends StatelessWidget {
  const RequestPairDeviceCard({
    super.key,
    required this.pairDevice,
    required this.onAccept,
    required this.onReject,
  });

  final PairDevice pairDevice;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: pairDevice.pairStatus == 'PENDING'
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Badge(
                  badgeContent:
                      CustomText(text: pairDevice.pairStatus.toLowerCase()),
                  badgeStyle: const BadgeStyle(badgeColor: Colors.blue),
                ),
                if (pairDevice.pairStatus == 'PENDING') ...[
                  Row(
                    children: [
                      IconButton(
                          iconSize: 40,
                          color: ColorName.primary,
                          onPressed: onAccept,
                          icon: const Icon(Icons.check_circle)),
                      IconButton(
                          iconSize: 40,
                          color: Colors.red,
                          onPressed: onReject,
                          icon: const Icon(Icons.cancel)),
                    ],
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
