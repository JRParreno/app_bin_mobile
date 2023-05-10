import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CommonEvent extends Equatable
    implements ProfileEvent, AppStatsEvent, AppsEvent {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialEvent extends CommonEvent {
  const InitialEvent();
}

class NoInternetConnectionEvent extends CommonEvent {
  const NoInternetConnectionEvent();
}
