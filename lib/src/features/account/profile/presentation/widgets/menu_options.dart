import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/utils/profile_utils.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/screen/view_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MenuOptions extends StatelessWidget {
  final BuildContext ctx;
  const MenuOptions({super.key, required this.ctx});

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
              onTap: () {},
              trailing: const Icon(Icons.chevron_right),
              enableFeedback: true,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: 'Change Password'),
              leading: const Icon(Icons.visibility_off),
              onTap: () {},
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: const CustomText(text: "View Device(s)"),
              leading: const Icon(Icons.device_hub),
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const ViewDeviceScreen(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
                // final user = await LocalStorage.readLocalStorage('_user');

                // if (user == null) {
                //   Future.delayed(const Duration(milliseconds: 500), () {
                //     BlocProvider.of<ProfileBloc>(context)
                //         .add(SetProfileLogoutEvent());
                //   });
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
