import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/remote_block/remote_add_usage_limit_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/usage_limit.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RemoteBlockScreenArgs {
  final Device device;

  RemoteBlockScreenArgs({
    required this.device,
  });
}

class RemoteBlockScreen extends StatefulWidget {
  static const String routeName = '/block/remote';
  const RemoteBlockScreen({super.key, required this.args});

  final RemoteBlockScreenArgs args;

  @override
  State<RemoteBlockScreen> createState() => _RemoteBlockScreenState();
}

class _RemoteBlockScreenState extends State<RemoteBlockScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Life's better without scrolling",
        ),
      ),
      body: Column(
        children: [
          Flexible(child: Assets.json.socialMediaInfluencer.lottie()),
          Flexible(
            child: UsageLimit(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: RemoteAddUsageLimitScreen(
                      args: RemoteAddUsageLimitScreenArgs(
                          device: widget.args.device)),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
