import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
