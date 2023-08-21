import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';

abstract class AppWeekRepository {
  Future<AppWeek> addAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  });
}
