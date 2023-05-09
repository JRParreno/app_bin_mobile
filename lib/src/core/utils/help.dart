import 'dart:async';

import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
// import 'package:device_apps/device_apps.dart';

class Helper {
  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  static List<AppUsageInfo> filterMyApps(List<Application> myApps) {
    return [];
  }

  static List<List<DateTime>> getWeeksForRange({
    required DateTime start,
    required DateTime end,
  }) {
    var result = <List<DateTime>>[];

    var date = start;
    var week = <DateTime>[];

    while (date.difference(end).inDays <= 0) {
      // start new week on Monday
      if (date.weekday == 1 && week.isNotEmpty) {
        result.add(week);
        week = <DateTime>[];
      }
      week.add(date);

      date = date.add(const Duration(days: 1));
    }

    result.add(week);

    return result;
  }

  static FutureOr<List<List<AppUsageInfo>>> getAppUsage() async {
    List<List<AppUsageInfo>> weekUsageInfo = [];
    final date = DateTime.now();
    final startDate = getDate(date.subtract(Duration(days: date.weekday - 1)));

    final weeksRange = getWeeksForRange(start: startDate, end: date);

    for (var i = 0; i < weeksRange.first.length; i++) {
      final element = weeksRange.first[i];
      final startDateRange =
          DateTime(element.year, element.month, element.day, 0);
      final endDateRange = date.day == element.day
          ? date
          : DateTime(element.year, element.month, element.day, 23, 59);
      final appUsageInfoList =
          await AppUsage().getAppUsage(startDateRange, endDateRange);
      weekUsageInfo.add(appUsageInfoList);

      if (date.day == element.day) break;
    }

    return weekUsageInfo;
  }

  static int getMaxHours(List<AppUsageInfo> appUsageInfos) {
    int total = 0;
    for (var i = 0; i < appUsageInfos.length; i++) {
      final element = appUsageInfos[i];
      if (total < element.usage.inHours) {
        total = element.usage.inHours;
      }
    }
    return total;
  }

  static String getDayName(int weekDay) {
    switch (weekDay) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";

      case 3:
        return "Wed";
      case 4:
        return "Thurs";

      case 5:
        return "Fri";

      case 6:
        return "Sat";

      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  static String? regexTest({
    required RegExp regex,
    required String value,
    required errorText,
  }) {
    final sames = value.isEmpty
        ? "Required"
        : regex.hasMatch(value)
            ? null
            : errorText;
    return sames;
  }
}
