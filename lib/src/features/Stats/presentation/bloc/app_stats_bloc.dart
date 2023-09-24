import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_data_repository_impl.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_stats_event.dart';
part 'app_stats_state.dart';

class AppStatsBloc extends Bloc<AppStatsEvent, AppStatsState> {
  AppStatsBloc() : super(const InitialState()) {
    on<AppStatsCurrentUsage>(_appStatsCurrentUsage);
    on<AppStatsInitialUsage>(_appStatsInitialUsage);
    on<AppStatsFetchUsage>(_appStatsFetchUsage);
  }

  void _appStatsCurrentUsage(
    AppStatsCurrentUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    emit(const LoadingState());

    final usageInfos = await Helper.getDailyAppUsage();
    final apps = await Helper.getListOfApps();
    final duration = await Helper.getCurrentDuration(
      appBinstats: usageInfos,
    );
    final today = DateTime.now();

    return emit(AppStatsLoaded(
      appUsage: [usageInfos],
      duration: duration,
      apps: apps,
      filterDate: today,
    ));
  }

  void _appStatsInitialUsage(
    AppStatsInitialUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    final duration =
        await Helper.getCurrentDuration(appBinstats: event.appBinStats.last);
    final today = DateTime.now();
    return emit(
      AppStatsLoaded(
        appUsage: event.appBinStats,
        duration: duration,
        apps: event.apps,
        filterDate: today,
      ),
    );
  }

  void _appStatsFetchUsage(
    AppStatsFetchUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    final date = event.date;

    final startDate = Helper.findFirstDateOfTheWeek(date);
    final endDate = Helper.findLastDateOfTheWeek(date);

    final state = this.state;

    if (state is AppStatsLoaded) {
      emit(const LoadingState());
      try {
        final appBinStatList = await AppWeekRepositoryImpl().fetchAppData(
            startDate: startDate,
            endDate: endDate,
            deviceCode: event.deviceCode);

        final duration =
            await Helper.getCurrentDuration(appBinstats: appBinStatList);

        return emit(
          AppStatsLoaded(
            appUsage: Helper.fetchAppDataToAppBinStats(appBinStatList),
            duration: duration,
            apps: state.apps,
            filterDate: date,
          ),
        );
      } catch (e) {
        return emit(ErrorState(e.toString()));
      }
    }
  }
}
