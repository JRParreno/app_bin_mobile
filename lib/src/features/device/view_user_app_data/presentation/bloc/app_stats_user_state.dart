// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_stats_user_bloc.dart';

abstract class AppStatsUserState extends Equatable {
  const AppStatsUserState();

  @override
  List<Object?> get props => [];
}

class AppStatsUserLoaded extends AppStatsUserState {
  final List<List<AppBinStats>> appUsage;
  final Duration duration;
  final DateTime? start;
  final DateTime? end;
  final DateTime filterDate;

  const AppStatsUserLoaded({
    required this.appUsage,
    required this.duration,
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
        filterDate,
      ];
}
