import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';

abstract class DeviceRepository {
  Future<Device?> getUserDevice({
    required String deviceCode,
  });
  Future<Device> registerUserDevice({
    required String deviceCode,
    required String deviceName,
  });

  Future<void> syncDeviceApps(List<DeviceApp> apps);
}
