import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_widget.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/prompt_block_screen.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppInstalledTile extends StatelessWidget {
  const AppInstalledTile({
    super.key,
    required this.app,
    this.isBlock = false,
    this.disableOnTap = false,
    this.schedule,
  });

  final ApplicationWithIcon app;
  final bool isBlock;
  final bool disableOnTap;
  final Schedule? schedule;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disableOnTap) {
          if (isAppBlock()) {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: PromptBlockScreen(args: PromptBlockArgs(app: app)),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            DeviceApps.openApp(app.packageName);
          }
        }
      },
      child: AppWidget(
        app: app,
      ),
    );
  }

  bool isAppBlock() {
    final DateTime now = DateTime.now();
    final mySchedule = schedule;

    if (mySchedule != null) {
      final myDateTime = mySchedule.myDateTime;

      final endTime = DateTime(
              mySchedule.myDateTime.year,
              mySchedule.myDateTime.month,
              mySchedule.myDateTime.day,
              mySchedule.myDateTime.hour,
              mySchedule.myDateTime.minute)
          .add(Duration(hours: mySchedule.hours, minutes: mySchedule.minutes));

      return now.isAfter(myDateTime) && now.isBefore(endTime);
    }

    return false;
  }
}
