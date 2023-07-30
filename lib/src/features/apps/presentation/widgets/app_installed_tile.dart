import 'package:app_bin_mobile/src/features/apps/presentation/widgets/app_widget.dart';
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
  });

  final ApplicationWithIcon app;
  final bool isBlock;
  final bool disableOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disableOnTap) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: PromptBlockScreen(args: PromptBlockArgs(app: app)),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      },
      child: AppWidget(
        app: app,
      ),
    );
  }
}
