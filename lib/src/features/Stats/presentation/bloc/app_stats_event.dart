part of 'app_stats_bloc.dart';

abstract class AppStatsEvent extends Equatable {
  const AppStatsEvent();

  @override
  List<Object?> get props => [];
}

class AppStatsCurrentUsage extends AppStatsEvent {
  final DateTime? startTime;
  final DateTime? endTime;

  const AppStatsCurrentUsage({
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [
        startTime,
        endTime,
      ];
}

class AppStatsInitialUsage extends AppStatsEvent {
  final List<List<AppBinStats>> appBinStats;
  final List<Application> apps;

  const AppStatsInitialUsage({
    required this.appBinStats,
    required this.apps,
  });

  @override
  List<Object?> get props => [
        appBinStats,
        apps,
      ];
}

class AppStatsFetchUsage extends AppStatsEvent {
  final DateTime date;
  final String deviceCode;

  const AppStatsFetchUsage({
    required this.date,
    required this.deviceCode,
  });

  @override
  List<Object?> get props => [
        date,
        deviceCode,
      ];
}
