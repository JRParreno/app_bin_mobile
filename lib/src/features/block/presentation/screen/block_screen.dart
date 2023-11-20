import 'package:app_bin_mobile/gen/assets.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/block/presentation/screen/add_usage_limit_screen.dart';
import 'package:app_bin_mobile/src/features/block/presentation/widget/usage_limit/usage_limit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BlockScreen extends StatefulWidget {
  static const String routeName = '/block';
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  @override
  void initState() {
    getApps();
    super.initState();
  }

  void getApps() async {
    final tempList = await Helper.getListOfApps();

    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AppsBloc>(context).add(
        AppsLoadEvent(
          applications: Helper.filterApps(tempList
            ..sort((a, b) {
              return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
            })),
        ),
      );
    });
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
          Flexible(child: UsageLimit(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const AddUsageLimitScreen(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
          )),
        ],
      ),
    );
  }
}
