import 'dart:async';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:intl/intl.dart';

import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';
import 'package:app_bin_mobile/src/features/stats/data/repository/app_week_filter_repository.dart';

class AppWeekFilterRepositoryImpl implements AppWeekFilterRepository {
  final dateFormat = DateFormat('MM-d-yyyy');

  @override
  FutureOr<List<AppWeek>> filterAppWeeks({
    DateTime? startDate,
    DateTime? endDate,
    required String deviceCode,
  }) async {
    String url =
        '${AppConstant.apiUrl}/app-week-list?device_code=$deviceCode&limit=700';
    Map<String, String> data = {"device_code": deviceCode};

    if (startDate != null && endDate != null) {
      final startDateFormatted = dateFormat.format(startDate);
      final endDateFormatted = dateFormat.format(endDate);

      data = {
        "start_date": startDateFormatted,
        "end_date": endDateFormatted,
        "device_code": deviceCode
      };
      url += '&start_date=$startDateFormatted&end_date=$endDateFormatted';
    }

    return await ApiInterceptor.apiInstance()
        .get(url, data: data)
        .then((value) {
      List<AppWeek> response = [];
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        response = results.map((e) => AppWeek.fromMap(e)).toList();
        return response;
      }

      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
