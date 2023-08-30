import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/features/device/add_device/presentation/screen/add_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ViewDeviceScreen extends StatefulWidget {
  static const String routeName = '/view-device-screen';

  const ViewDeviceScreen({super.key});

  @override
  State<ViewDeviceScreen> createState() => _ViewDeviceScreenState();
}

class _ViewDeviceScreenState extends State<ViewDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Device(s)"),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddDeviceScreen(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
