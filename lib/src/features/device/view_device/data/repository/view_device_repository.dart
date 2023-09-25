import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';

abstract class ViewDeviceRepository {
  Future<List<PairDevice>> getPairDevices();
}
