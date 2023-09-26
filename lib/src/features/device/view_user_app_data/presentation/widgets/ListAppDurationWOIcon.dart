import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:flutter/material.dart';

class ListAppDurationWOIcon extends StatelessWidget {
  const ListAppDurationWOIcon({
    Key? key,
    required this.apps,
  }) : super(key: key);

  final List<AppBinStats> apps;

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
                          Text(item.appName, maxLines: 1),
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
