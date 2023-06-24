import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
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

  static FutureOr<List<AppBinStats>> getCurrentAppUsage({
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
        duration += Duration(hours: element.hours, minutes: element.minutes);
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

  static FutureOr<List<List<AppBinStats>>> getAppUsage({
    DateTime? startTime,
    DateTime? endTime,
  }) async {
    List<List<AppUsageInfo>> weekUsageInfo = [];
    List<List<AppBinStats>> appBinStats = [];

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

    for (var i = 0; i < weekUsageInfo.length; i++) {
      final element = weekUsageInfo[i];
      final appBinStatsList = await convertToListAppBinStats(element);
      appBinStats.add(appBinStatsList);
    }

    return appBinStats;
  }

  static double getMaxHours(List<AppUsageInfo> appUsageInfos) {
    double total = 0;
    for (var i = 0; i < appUsageInfos.length; i++) {
      final element = appUsageInfos[i];
      final minutesToHrs = element.usage.inMinutes * 0.0166667;
      final hours = element.usage.inHours;
      total = hours + minutesToHrs;
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
    final apps = state.appUsage.where((e) => e.isNotEmpty).toList();
    Duration duration = const Duration();

    if (apps.isNotEmpty && apps.last.isNotEmpty) {
      final tempLast = apps.last;
      for (var i = 0; i < tempLast.length; i++) {
        final element = tempLast[i];
        duration += Duration(hours: element.hours, minutes: element.minutes);
      }
    }

    return apps.isNotEmpty
        ? apps.map((e) {
            return AppUsageChartData(
                dayName: Helper.getDayName(e.last.startDate.weekday),
                duration: duration);
          }).toList()
        : [];
  }

  static AppBinStats convertToAppBinStats(AppUsageInfo appUsageInfo) {
    return AppBinStats(
      id: '',
      appServiceId: '',
      appName: appUsageInfo.appName,
      packageName: appUsageInfo.packageName,
      hours: appUsageInfo.usage.inHours,
      minutes: appUsageInfo.usage.inMinutes,
      startDate: appUsageInfo.startDate,
      endDate: appUsageInfo.endDate,
    );
  }

  static Future<List<AppBinStats>> convertToListAppBinStats(
      List<AppUsageInfo> appUsageInfos) async {
    final List<AppBinStats> tempAppBinStats = [];

    final tempList =
        await DeviceApps.getInstalledApplications(includeAppIcons: true);
    tempList
        .where((element) =>
            element.category == ApplicationCategory.game ||
            element.category == ApplicationCategory.social ||
            element.category == ApplicationCategory.productivity)
        .toList();

    for (var i = 0; i < appUsageInfos.length; i++) {
      final appUsageInfo = appUsageInfos[i];
      final app = tempList.firstWhereOrNull(
          (element) => element.packageName == appUsageInfo.packageName);
      final appBinStats = convertToAppBinStats(appUsageInfo);

      if (app != null) {
        final appIcon = app as ApplicationWithIcon;
        appBinStats.copyWith(icon: appIcon.icon);
      }
      tempAppBinStats.add(convertToAppBinStats(appUsageInfo));
    }

    return tempAppBinStats;
  }
}
