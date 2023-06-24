// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_stats_bloc.dart';

abstract class AppStatsState extends Equatable {
  const AppStatsState();

  @override
  List<Object?> get props => [];
}

class AppStatsLoaded extends AppStatsState {
  final List<List<AppBinStats>> appUsage;
  final DateTime? start;
  final DateTime? end;

  const AppStatsLoaded({
    required this.appUsage,
    this.start,
    this.end,
  });

  @override
  List<Object?> get props => [
        start,
        end,
        appUsage,
      ];
}
