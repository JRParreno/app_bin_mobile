import 'dart:async';

import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';

abstract class AppWeekFilterRepository {
  FutureOr<List<AppWeek>> filterAppWeeks({
    DateTime? startDate,
    DateTime? endDate,
    required String deviceCode,
  });
}
