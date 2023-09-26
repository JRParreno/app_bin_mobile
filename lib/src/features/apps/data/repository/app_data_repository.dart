import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';

abstract class AppWeekRepository {
  Future<void> addAppData({
    required AppBinStats appBinStats,
    required String deviceCode,
  });
  Future<List<AppBinStats>> fetchAppData({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
    String? pk,
  });
}
