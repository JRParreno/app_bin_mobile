// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_stats_bloc.dart';

abstract class AppStatsState extends Equatable {
  const AppStatsState();

  @override
  List<Object?> get props => [];
}

class AppStatsLoaded extends AppStatsState {
  final List<List<AppBinStats>> appUsage;
  final List<Application> apps;
  final Duration duration;
  final DateTime? start;
  final DateTime? end;
  final DateTime filterDate;

  const AppStatsLoaded({
    required this.appUsage,
    required this.duration,
    required this.apps,
    required this.filterDate,
    this.start,
    this.end,
  });

  @override
  List<Object?> get props => [
        start,
        end,
        appUsage,
        duration,
        apps,
        filterDate,
      ];
}
