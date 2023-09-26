import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/device/request_device/presentation/bloc/request_pair_device_user_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/presentation/bloc/view_all_user_device_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_device/presentation/bloc/pair_device_user_bloc.dart';
import 'package:app_bin_mobile/src/features/device/view_user_app_data/presentation/bloc/app_stats_user_bloc.dart';
import 'package:app_bin_mobile/src/features/stats/presentation/bloc/app_stats_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable
    implements
        ProfileState,
        AppStatsState,
        AppsState,
        PairDeviceUserState,
        RequestPairDeviceUserState,
        ViewAllUserDeviceState,
        AppStatsUserState {
  const CommonState();
  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialState extends CommonState {
  const InitialState();
}

// loading state for all blocs
class LoadingState extends CommonState {
  const LoadingState();
}

class EmptyState extends CommonState {
  const EmptyState();
}

class ErrorState extends CommonState {
  final String error;
  const ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class NoInternetConnectionState extends CommonState {
  const NoInternetConnectionState();
}

class ServerExceptionState extends CommonState {
  final String error;
  const ServerExceptionState(this.error);

  @override
  List<Object> get props => [error];
}

class TimeoutExceptionState extends CommonState {
  final String error;
  const TimeoutExceptionState(this.error);

  @override
  List<Object> get props => [error];
}
