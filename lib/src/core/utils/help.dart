import 'dart:async';

import 'package:app_bin_mobile/src/features/stats/models/chart_data.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
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

  static FutureOr<List<AppUsageInfo>> getCurrentAppUsage({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final tempAppUsage =
        await getAppUsage(endTime: endTime, startTime: startTime);
    return tempAppUsage.first;
  }

  static Future<Duration> getCurrentDuration() async {
    Duration duration = const Duration();
    final appUsages = await Helper.getAppUsage();
    if (appUsages.isNotEmpty && appUsages.last.isNotEmpty) {
      final tempLast = appUsages.last;
      for (var i = 0; i < tempLast.length; i++) {
        final element = tempLast[i];
        duration += element.usage;
      }
    }
    return duration;
  }

  static List<Application> filterApps(
    List<Application> apps,
  ) {
    return apps
        .where((element) =>
            element.category == ApplicationCategory.game ||
            element.category == ApplicationCategory.social ||
            element.category == ApplicationCategory.productivity)
        .toList();
  }

  static List<AppUsageInfo> filterAppUsageInfo({
    required List<AppUsageInfo> usages,
    required List<Application> apps,
  }) {
    List<Application> appList = [];

    appList = filterApps(apps);

    return usages.where((e) {
      final checkAppExists = appList.where((element) {
        return element.packageName == e.packageName;
      }).toList();
      return checkAppExists.isNotEmpty;
    }).toList();
  }

  static FutureOr<List<List<AppUsageInfo>>> getAppUsage({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    List<List<AppUsageInfo>> weekUsageInfo = [];
    final date = startTime ?? DateTime.now();
    final startDate = endTime != null
        ? getDate(endTime.subtract(Duration(days: endTime.weekday - 1)))
        : getDate(date.subtract(Duration(days: date.weekday - 1)));

    final weeksRange = getWeeksForRange(start: startDate, end: date);
    final tempList = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
    );

    for (var i = 0; i < weeksRange.first.length; i++) {
      final element = weeksRange.first[i];
      final startDateRange =
          DateTime(element.year, element.month, element.day, 0);
      final endDateRange = date.day == element.day
          ? date
          : DateTime(element.year, element.month, element.day, 23, 59);
      final tempAppUsageInfoList =
          await AppUsage().getAppUsage(startDateRange, endDateRange);
      final appUsageInfoList =
          filterAppUsageInfo(usages: tempAppUsageInfoList, apps: tempList);

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

  static List<AppUsageChartData> getAppUsageChartData(AppStatsLoaded state) {
    return state.appUsage.map((e) {
      return AppUsageChartData(
          dayName: Helper.getDayName(e.last.startDate.weekday),
          totalHrs: Helper.getMaxHours(e));
    }).toList();
  }
}
