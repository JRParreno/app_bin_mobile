import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_stats_event.dart';
part 'app_stats_state.dart';

class AppStatsBloc extends Bloc<AppStatsEvent, AppStatsState> {
  AppStatsBloc() : super(const InitialState()) {
    on<AppStatsCurrentUsage>(_appStatsCurrentUsage);
    on<AppStatsInitialUsage>(_appStatsInitialUsage);
  }

  void _appStatsCurrentUsage(
    AppStatsCurrentUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    final usageInfos = await Helper.getDailyAppUsage();
    final apps = await Helper.getListOfApps();
    final duration = await Helper.getCurrentDuration(
      appBinstats: usageInfos,
    );

    return emit(AppStatsLoaded(
      appUsage: [usageInfos],
      duration: duration,
      apps: apps,
    ));
  }

  void _appStatsInitialUsage(
    AppStatsInitialUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    final duration =
        await Helper.getCurrentDuration(appBinstats: event.appBinStats.last);
    return emit(
      AppStatsLoaded(
        appUsage: event.appBinStats,
        duration: duration,
        apps: event.apps,
      ),
    );
  }
}
