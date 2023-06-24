import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppBinStats {
  final String id;
  final String appServiceId;
  final String appName;
  final String packageName;
  final int hours;
  final int minutes;
  final DateTime startDate;
  final DateTime endDate;
  final Uint8List? icon;

  AppBinStats({
    required this.id,
    required this.appServiceId,
    required this.appName,
    required this.packageName,
    required this.hours,
    required this.minutes,
    required this.startDate,
    required this.endDate,
    this.icon,
  });

  AppBinStats copyWith({
    String? id,
    String? appServiceId,
    String? appName,
    String? packageName,
    int? hours,
    int? minutes,
    DateTime? startDate,
    DateTime? endDate,
    Uint8List? icon,
  }) {
    return AppBinStats(
      id: id ?? this.id,
      appServiceId: appServiceId ?? this.appServiceId,
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'appServiceId': appServiceId});
    result.addAll({'appName': appName});
    result.addAll({'packageName': packageName});
    result.addAll({'hours': hours});
    result.addAll({'minutes': minutes});
    result.addAll({'startDate': startDate.millisecondsSinceEpoch});
    result.addAll({'endDate': endDate.millisecondsSinceEpoch});

    return result;
  }

  factory AppBinStats.fromMap(Map<String, dynamic> map) {
    return AppBinStats(
      id: map['id'] ?? '',
      appServiceId: map['appServiceId'] ?? '',
      appName: map['appName'] ?? '',
      packageName: map['packageName'] ?? '',
      hours: map['hours']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      icon: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppBinStats.fromJson(String source) =>
      AppBinStats.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppBinStats(id: $id, appServiceId: $appServiceId, appName: $appName, packageName: $packageName, hours: $hours, minutes: $minutes, startDate: $startDate, endDate: $endDate, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppBinStats &&
        other.id == id &&
        other.appServiceId == appServiceId &&
        other.appName == appName &&
        other.packageName == packageName &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        appServiceId.hashCode ^
        appName.hashCode ^
        packageName.hashCode ^
        hours.hashCode ^
        minutes.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        icon.hashCode;
  }
}
