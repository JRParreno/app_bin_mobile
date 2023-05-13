import 'package:app_bin_mobile/src/features/block/presentation/screen/prompt_block_screen.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppInstalledTile extends StatelessWidget {
  final ApplicationWithIcon app;
  final bool isBlock;

  const AppInstalledTile({
    super.key,
    required this.app,
    this.isBlock = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: PromptBlockScreen(args: PromptBlockArgs(app: app)),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const Divider(
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
