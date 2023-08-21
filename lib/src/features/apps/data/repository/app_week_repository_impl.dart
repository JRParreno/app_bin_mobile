import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/app_week.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/app_week_repository.dart';

class AppWeekRepositoryImpl extends AppWeekRepository {
  @override
  Future<AppWeek> addAppWeek({
    required DateTime startDate,
    required DateTime endDate,
    required String deviceCode,
  }) async {
    String url = '${AppConstant.apiUrl}/app-week-list';
    final data = {
      "start_date": startDate.toIso8601String(),
      "end_date": endDate.toIso8601String(),
      "device_code": deviceCode
    };

    return await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .then((value) {
      return AppWeek(
          pk: value.data['pk'].toString(),
          startDate: DateTime.parse(value.data['startDate']),
          endDate: DateTime.parse(value.data['endDate']));
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
