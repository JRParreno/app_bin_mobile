import 'package:app_bin_mobile/src/features/block/data/models/schedule.dart';

abstract class ScheduleRepository {
  Future<Schedule?> getSchedule(String devicePk);
  Future<Schedule> createSchedule(Schedule schedule);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> deleteSchedule(String pk);
}
