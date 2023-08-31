import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';

abstract class AppWeekRepository {
  Future<void> addAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  });
  Future<AppWeek?> fetchAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  });
  Future<void> addAppData(AppBinStats appBinStats);
}
