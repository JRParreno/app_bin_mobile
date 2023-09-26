import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/device/view_user_app_data/presentation/bloc/app_stats_user_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_user_app_data/presentation/screen/apps_statistics_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.device,
    required this.userPk,
  });

  final Device device;
  final String userPk;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final today = DateTime.now();

        BlocProvider.of<AppStatsUserBloc>(context).add(
          AppStatsFetchUserUsage(
            date: today,
            deviceCode: device.deviceCode,
            userPk: userPk,
          ),
        );
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: AppsStatisticsUserScreen(
            userPk: userPk,
            deviceCode: device.deviceCode,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Device name: ${device.deviceName}'),
                  CustomText(text: 'Device code: ${device.deviceCode}')
                ],
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
