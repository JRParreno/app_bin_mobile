import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';
import 'package:app_bin_mobile/src/features/device/view_user_app_data/presentation/bloc/app_stats_user_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/stats/data/models/chart_data.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';
// import 'package:device_apps/device_apps.dart';

class Helper {
  static DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  static List<AppUsageInfo> filterMyApps(List<Application> myApps) {
    return [];
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static List<List<DateTime>> getWeeksForRange({
    DateTime? start,
    DateTime? end,
  }) {
    final today = DateTime.now();

    final endDate = end ?? findLastDateOfTheWeek(today);
    final startDate = start ?? findFirstDateOfTheWeek(today);

    var result = <List<DateTime>>[];

    var date = startDate;
    var week = <DateTime>[];

    while (date.difference(end ?? endDate).inDays <= 0) {
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

  static Future<Duration> getCurrentDuration({
    List<AppBinStats>? appBinstats,
  }) async {
    Duration duration = const Duration();
    final appUsages = appBinstats ?? await Helper.getDailyAppUsage();
    if (appUsages.isNotEmpty) {
      for (var i = 0; i < appUsages.length; i++) {
        final element = appUsages[i];
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

  static List<UsageInfo> filterAppUsageInfo({
    required List<UsageInfo> usages,
    required List<Application> apps,
  }) {
    List<UsageInfo> filterAppUsages = [];

    filterAppUsages = usages.where((e) {
      final checkAppExists = apps.where((element) {
        return element.packageName == e.packageName;
      }).toList();
      return checkAppExists.isNotEmpty;
    }).toList();

    return filterAppUsages;
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
    final List<AppUsageChartData> chartData = [];

    if (apps.isNotEmpty && apps.last.isNotEmpty) {
      for (var i = 0; i < apps.length; i++) {
        Duration duration = const Duration();

        final parentElement = apps[i];

        for (var j = 0; j < parentElement.length; j++) {
          final element = parentElement[j];

          duration += Duration(hours: element.hours, minutes: element.minutes);
        }
        chartData.add(
          AppUsageChartData(
              dayName: Helper.getDayName(parentElement.last.startDate.weekday),
              duration: duration),
        );
      }
    }

    return chartData;
  }

  static List<AppUsageChartData> getAppUsageUserChartData(
      AppStatsUserLoaded state) {
    final apps = state.appUsage.where((e) => e.isNotEmpty).toList();
    final List<AppUsageChartData> chartData = [];

    if (apps.isNotEmpty && apps.last.isNotEmpty) {
      for (var i = 0; i < apps.length; i++) {
        Duration duration = const Duration();

        final parentElement = apps[i];

        for (var j = 0; j < parentElement.length; j++) {
          final element = parentElement[j];

          duration += Duration(hours: element.hours, minutes: element.minutes);
        }
        chartData.add(
          AppUsageChartData(
              dayName: Helper.getDayName(parentElement.last.startDate.weekday),
              duration: duration),
        );
      }
    }

    return chartData;
  }

  static AppBinStats convertToAppBinStats({
    required UsageInfo appUsageInfo,
    String? appName,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final totalForegroundInMinutes =
        int.parse(appUsageInfo.totalTimeInForeground!) / 1000 / 60;

    final int minutes = totalForegroundInMinutes.toInt();
    final hours = (minutes * 0.0166667).toInt();

    return AppBinStats(
      id: '',
      appName: appName ?? '',
      packageName: appUsageInfo.packageName ?? '',
      hours: hours,
      minutes: minutes > 60 ? (minutes / 60).round() : minutes,
      startDate: startDate,
      endDate: endDate,
    );
  }

  static Future<List<AppBinStats>> convertToListAppBinStats({
    required List<UsageInfo> appUsageInfos,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final List<AppBinStats> tempAppBinStats = [];

    final tempList = await getListOfApps();

    for (var i = 0; i < appUsageInfos.length; i++) {
      final appUsageInfo = appUsageInfos[i];
      final app = tempList.firstWhereOrNull(
          (element) => element.packageName == appUsageInfo.packageName);
      final appBinStats = convertToAppBinStats(
        appUsageInfo: appUsageInfo,
        appName: app?.appName,
        startDate: startDate,
        endDate: endDate,
      );

      if (app != null) {
        final appIcon = app as ApplicationWithIcon;
        appBinStats.copyWith(icon: appIcon.icon);
      }
      tempAppBinStats.add(appBinStats);
    }

    return tempAppBinStats;
  }

  static Future<List<Application>> getListOfApps() async {
    final tempList = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
    );

    final tempSystemApps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    final systemApps = tempSystemApps
        .where((element) =>
            element.packageName == 'com.android.chrome' ||
            element.packageName.contains('com.google.android'))
        .toList();

    final appList = tempList
        .where((element) =>
            element.category == ApplicationCategory.game ||
            element.category == ApplicationCategory.social ||
            element.category == ApplicationCategory.productivity ||
            element.category == ApplicationCategory.video)
        .toList();

    final result = [...appList, ...systemApps];

    return result.toSet().toList();
  }

  static FutureOr<List<AppBinStats>> getDailyAppUsage(
      {List<Application>? apps}) async {
    final endDate = DateTime.now();
    final startDate = DateTime(endDate.year, endDate.month, endDate.day);
    final tempList = apps ?? await getListOfApps();

    final tempAppUsageInfoList =
        await usageInfos(startDate: startDate, endDate: endDate);

    final sortHighUsage = tempAppUsageInfoList
      ..sort((a, b) {
        final aTotalForeground =
            int.parse(a.totalTimeInForeground!) / 1000 / 60;
        final bTotalForeground =
            int.parse(b.totalTimeInForeground!) / 1000 / 60;
        return aTotalForeground.compareTo(bTotalForeground);
      });

    final appUsageInfoList =
        filterAppUsageInfo(usages: sortHighUsage, apps: tempList);

    final appBinStatsList = await convertToListAppBinStats(
      appUsageInfos: appUsageInfoList,
      startDate: startDate,
      endDate: endDate,
    );

    return appBinStatsList;
  }

  static List<List<AppBinStats>> fetchAppDataToAppBinStats(
      List<AppBinStats> stats) {
    List<List<AppBinStats>> results = [];
    List<AppBinStats> tempAppBinStats = [];

    if (stats.isNotEmpty) {
      for (int i = 0; i < stats.length; i++) {
        final currentStat = stats[i];

        if (i == (stats.length - 1)) {
          tempAppBinStats.add(currentStat);
          results.add(tempAppBinStats);
        } else {
          if (!DateUtils.isSameDay(
              currentStat.startDate, stats[i + 1].startDate)) {
            results.add(tempAppBinStats);
            tempAppBinStats = [];
          }
          tempAppBinStats.add(currentStat);
        }
      }
    } else {
      results.add([]);
    }

    return results;
  }

  static Future<List<UsageInfo>> usageInfos({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final List<UsageInfo> infos = [];

    final usage = await UsageStats.queryUsageStats(startDate, endDate);

    for (var i in usage) {
      String currentForeground = i.totalTimeInForeground!;

      if (double.parse(currentForeground) > 0) {
        final usageExists = infos.firstWhereOrNull(
            (element) => element.packageName == i.packageName);
        if (usageExists != null) {
          final usageForeGround =
              double.parse(usageExists.totalTimeInForeground!);

          if (usageForeGround > double.parse(currentForeground)) {
            currentForeground = usageExists.totalTimeInForeground!;
          }
          infos.remove(usageExists);
        }
        infos.add(
          UsageInfo(
            firstTimeStamp: i.firstTimeStamp,
            lastTimeStamp: i.lastTimeStamp,
            lastTimeUsed: i.lastTimeUsed,
            packageName: i.packageName,
            totalTimeInForeground: currentForeground,
          ),
        );
      }
    }

    return infos;
  }

  static List<DeviceApp> convertAppsToDeviceApps({
    required List<Application> apps,
    required String deviceId,
  }) {
    final convertedApps = apps
        .map((app) => DeviceApp.toDeviceApp(app: app, deviceId: deviceId))
        .toList();

    if (convertedApps.isNotEmpty) {
      return convertedApps;
    }

    return [];
  }
}
