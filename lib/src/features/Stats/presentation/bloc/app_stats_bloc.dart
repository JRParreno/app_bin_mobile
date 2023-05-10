import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/core/utils/help.dart';
import 'package:app_usage/app_usage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_stats_event.dart';
part 'app_stats_state.dart';

class AppStatsBloc extends Bloc<AppStatsEvent, AppStatsState> {
  AppStatsBloc() : super(const InitialState()) {
    on<AppStatsCurrentUsage>(_appStatsCurrentUsage);
  }

  void _appStatsCurrentUsage(
    AppStatsCurrentUsage event,
    Emitter<AppStatsState> emit,
  ) async {
    final usageInfos = await Helper.getAppUsage();
    return emit(AppStatsLoaded(appUsage: usageInfos));
  }
}
