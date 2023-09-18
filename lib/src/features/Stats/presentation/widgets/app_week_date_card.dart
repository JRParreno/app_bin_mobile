import 'package:app_bin_mobile/src/core/common_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';

class AppWeekDateCard extends StatelessWidget {
  const AppWeekDateCard({
    super.key,
    required this.appWeek,
  });

  final AppWeek appWeek;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomText(text: dateFormatted(appWeek.startDate)),
                const CustomText(text: ' - '),
                CustomText(text: dateFormatted(appWeek.endDate))
              ],
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  String dateFormatted(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}
