import 'package:intl/intl.dart';

import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_week_repository.dart';

class AppWeekRepositoryImpl extends AppWeekRepository {
  final dateFormat = DateFormat('MM-d-yyyy');

  @override
  Future<void> addAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  }) async {
    String url = '${AppConstant.apiUrl}/app-week-list';
    final startDateFormatted = dateFormat.format(startDate);
    final endDateFormatted = dateFormat.format(endDate);

    final data = {
      "start_date": startDateFormatted,
      "end_date": endDateFormatted,
      "device_code": deviceCode
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      return;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<AppWeek?> fetchAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  }) async {
    final startDateFormatted = dateFormat.format(startDate);
    final endDateFormatted = dateFormat.format(endDate);

    final data = {
      "start_date": startDateFormatted,
      "end_date": endDateFormatted,
      "device_code": deviceCode
    };

    String url =
        '${AppConstant.apiUrl}/app-week-list?device_code=$deviceCode&start_date=$startDateFormatted&end_date=$endDateFormatted';

    return await ApiInterceptor.apiInstance()
        .get(url, data: data)
        .then((value) {
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final response = AppWeek.fromMap(results.first);
        return response;
      }

      return null;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> addAppData(AppBinStats appBinStats) async {
    String url = '${AppConstant.apiUrl}/app-data-list';
    final startDateFormatted = dateFormat.format(appBinStats.startDate);
    final endDateFormatted = dateFormat.format(appBinStats.endDate);

    final data = {
      "start_date": startDateFormatted,
      "end_date": endDateFormatted,
      "package_name": appBinStats.packageName,
      "app_name": appBinStats.appName,
      "hours": appBinStats.hours,
      "minutes": appBinStats.minutes,
      "service_pk": appBinStats.appServiceId
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      return;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
