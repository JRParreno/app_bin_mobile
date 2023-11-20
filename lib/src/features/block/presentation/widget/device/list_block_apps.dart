import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/block/data/models/block_app.dart';
import 'package:flutter/material.dart';

class ListBlockApps extends StatelessWidget {
  const ListBlockApps({super.key, required this.blockApps});

  final List<BlockApp> blockApps;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: blockApps.length,
      itemBuilder: (context, index) {
        final blockApp = blockApps[index];
        if (!blockApp.deviceApp.isBlock) return const SizedBox();

        return Card(
          child: ListTile(
            leading: const Icon(Icons.app_blocking),
            title: CustomText(text: blockApp.deviceApp.appName),
          ),
        );
      },
    );
  }
}
