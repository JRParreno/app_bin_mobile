part of 'app_stats_bloc.dart';

abstract class AppStatsEvent extends Equatable {
  const AppStatsEvent();

  @override
  List<Object> get props => [];
}

class AppStatsCurrentUsage extends AppStatsEvent {}
