import 'package:app_bin_mobile/src/core/bloc/enums/view_status.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:flutter/material.dart';

class RemoteAppsTile extends StatelessWidget {
  const RemoteAppsTile({
    Key? key,
    required this.deviceApp,
    required this.onChangedSwitch,
  }) : super(key: key);

  final BlockApp deviceApp;
  final VoidCallback onChangedSwitch;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.app_blocking),
        title: CustomText(text: deviceApp.deviceApp.appName),
        trailing: deviceApp.viewStatus != ViewStatus.loading
            ? Switch(
                // This bool value toggles the switch.
                value: deviceApp.deviceApp.isBlock,
                thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                onChanged: (bool value) {
                  onChangedSwitch();
                },
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
