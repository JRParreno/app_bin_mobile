import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class ListAppDuration extends StatelessWidget {
  const ListAppDuration({
    Key? key,
    required this.apps,
    required this.currentApps,
  }) : super(key: key);

  final List<AppBinStats> apps;
  final List<Application> currentApps;

  String time(AppBinStats info) {
    String title = '';
    if (info.hours > 0) {
      title += '${info.hours} hrs ';
    }
    if (info.minutes > 0) {
      title +=
          '${info.minutes > 60 ? (info.minutes / 60).round() : info.minutes} mins';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    if (apps.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final item = apps[index];
          final tempApp = currentApps
              .where(
                (element) =>
                    element.packageName == item.packageName &&
                    (item.minutes > 0 || item.hours > 0),
              )
              .toList();
          if (tempApp.isNotEmpty) {
            final app = tempApp.first as ApplicationWithIcon;
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomText(
                        text: time(item),
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: ColorName.dimGray,
                )
              ],
            );
          }
          return const SizedBox();
        },
      );
    }
    return const Center(
      child: CustomText(
        text: "No apps recorded",
      ),
    );
  }
}
