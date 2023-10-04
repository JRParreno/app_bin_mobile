import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/presentation/screen/view_all_user_device_screen.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PairDeviceCard extends StatelessWidget {
  const PairDeviceCard({
    super.key,
    required this.pairDevice,
  });

  final PairDevice pairDevice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pairDevice.pairStatus == 'ACCEPTED'
          ? () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ViewAllUserDeviceScreen(
                    fullName: pairDevice.fullName,
                    pk: pairDevice.userPk.toString()),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }
          : null,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: pairDevice.pairStatus == 'ACCEPTED'
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
              if (pairDevice.pairStatus == 'ACCEPTED') ...[
                const Icon(Icons.chevron_right),
              ] else ...[
                badges.Badge(
                  badgeContent:
                      CustomText(text: pairDevice.pairStatus.toLowerCase()),
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blue),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
