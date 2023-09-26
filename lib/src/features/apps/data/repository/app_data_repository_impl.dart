import 'package:intl/intl.dart';

import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_bin_stats.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_data_repository.dart';

class AppWeekRepositoryImpl extends AppWeekRepository {
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Future<void> addAppData({
    required AppBinStats appBinStats,
    required String deviceCode,
  }) async {
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
  Future<List<AppBinStats>> fetchAppData({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
    String? pk,
  }) {
    final startDateFormatted = dateFormat.format(startDate);
    final endDateFormatted = dateFormat.format(endDate);
    List<AppBinStats> appBinStats = [];

    String url =
        '${AppConstant.apiUrl}/app-data-list?device_code=$deviceCode&start_date=$startDateFormatted&end_date=$endDateFormatted';
    if (pk != null) {
      url += '&user_pk=$pk';
    }

    return ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        appBinStats = results.map((e) => AppBinStats.fromMap(e)).toList();
      }
      return appBinStats;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
