import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';

abstract class ViewAllUserDeviceRepository {
  Future<List<Device>> fetchUserAllDevice(String pk);
}
