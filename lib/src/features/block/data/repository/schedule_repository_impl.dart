import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';
import 'package:app_bin_mobile/src/features/block/data/repository/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  @override
  Future<Schedule> createSchedule(Schedule schedule) async {
    String url = '${AppConstant.apiUrl}/schedule/create';

    final data = {
      "device": schedule.device,
      "hours": schedule.hours,
      "minutes": schedule.minutes,
      "is_hourly": schedule.isHourly,
      "my_date_time": schedule.myDateTime.toLocal().toString(),
    };

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
    )
        .then((value) {
      return Schedule.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> deleteSchedule(String pk) async {
    String url = '${AppConstant.apiUrl}/schedule/detail/$pk';

    return await ApiInterceptor.apiInstance()
        .delete(
      url,
    )
        .then((value) {
      return;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Schedule?> getSchedule(String devicePk) async {
    String url = '${AppConstant.apiUrl}/schedule/detail/$devicePk';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      return Schedule.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> updateSchedule(Schedule schedule) async {
    String url = '${AppConstant.apiUrl}/schedule/detail/${schedule.pk}';

    return await ApiInterceptor.apiInstance()
        .patch(
      url,
    )
        .then((value) {
      return;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
