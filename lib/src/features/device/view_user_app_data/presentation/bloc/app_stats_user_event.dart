part of 'app_stats_user_bloc.dart';

abstract class AppStatsUserEvent extends Equatable {
  const AppStatsUserEvent();

  @override
  List<Object?> get props => [];
}

class AppStatsUserCurrentUsage extends AppStatsUserEvent {
  final DateTime? startTime;
  final DateTime? endTime;

  const AppStatsUserCurrentUsage({
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [
        startTime,
        endTime,
      ];
}

class AppStatsUserInitialUsage extends AppStatsUserEvent {
  final List<List<AppBinStats>> appBinStats;
  final List<Application> apps;

  const AppStatsUserInitialUsage({
    required this.appBinStats,
    required this.apps,
  });

  @override
  List<Object?> get props => [
        appBinStats,
        apps,
      ];
}

class AppStatsFetchUserUsage extends AppStatsUserEvent {
  final DateTime date;
  final String deviceCode;
  final String userPk;

  const AppStatsFetchUserUsage({
    required this.date,
    required this.deviceCode,
    required this.userPk,
  });

  @override
  List<Object?> get props => [
        date,
        deviceCode,
        userPk,
      ];
}
