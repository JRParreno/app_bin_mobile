import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/change_password_screen.dart';
import 'package:app_bin_mobile/src/features/account/profile/presentation/screens/update_account_screen.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/screen/view_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MenuOptions extends StatelessWidget {
  final BuildContext ctx;
  final VoidCallback onCallBack;
  const MenuOptions({
    super.key,
    required this.ctx,
    required this.onCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: ColorName.primary),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: 'Update Information'),
              leading: const Icon(Icons.person),
              onTap: () {
                toNavigateScreen(
                  screen: const UpdateAccountScreen(),
                  context: context,
                );
              },
              trailing: const Icon(Icons.chevron_right),
              enableFeedback: true,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: 'Change Password'),
              leading: const Icon(Icons.visibility_off),
              onTap: () {
                toNavigateScreen(
                  screen: const ChangePasswordScreen(),
                  context: context,
                );
              },
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: "View Device(s)"),
              leading: const Icon(Icons.device_hub),
              onTap: () {
                toNavigateScreen(
                  screen: const ViewDeviceScreen(),
                  context: context,
                );
              },
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: 'Help'),
              leading: const Icon(Icons.help),
              onTap: () {},
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: 'About'),
              leading: const Icon(Icons.info),
              onTap: () {},
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 1),
            child: ListTile(
              title: const CustomText(text: 'Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                ProfileUtils.testAdaptiveAlert(ctx);
              },
            ),
          ),
        ],
      ),
    );
  }

  void toNavigateScreen(
      {required BuildContext context, required Widget screen}) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: screen,
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    ).whenComplete(() {
      onCallBack();
    });
  }
}
