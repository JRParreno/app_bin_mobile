import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_data_repository_impl.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_stats_user_event.dart';
part 'app_stats_user_state.dart';

class AppStatsUserBloc extends Bloc<AppStatsUserEvent, AppStatsUserState> {
  AppStatsUserBloc() : super(const InitialState()) {
    on<AppStatsFetchUserUsage>(_appStatsFetchUsage);
  }

  void _appStatsFetchUsage(
    AppStatsFetchUserUsage event,
    Emitter<AppStatsUserState> emit,
  ) async {
    final date = event.date;

    final startDate = Helper.findFirstDateOfTheWeek(date);
    final endDate = Helper.findLastDateOfTheWeek(date);

    emit(const LoadingState());

    try {
      final appBinStatList = await AppWeekRepositoryImpl().fetchAppData(
        startDate: startDate,
        endDate: endDate,
        deviceCode: event.deviceCode,
        pk: event.userPk,
      );

      final duration =
          await Helper.getCurrentDuration(appBinstats: appBinStatList);

      return emit(
        AppStatsUserLoaded(
          appUsage: Helper.fetchAppDataToAppBinStats(appBinStatList),
          duration: duration,
          filterDate: date,
        ),
      );
    } catch (e) {
      return emit(ErrorState(e.toString()));
    }
  }
}
