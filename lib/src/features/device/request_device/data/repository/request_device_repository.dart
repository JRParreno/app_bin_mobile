import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';

abstract class RequestDeviceRepository {
  Future<List<PairDevice>> getRequestPairDevices();
  Future<PairDevice> updateRequestPairDevices({
    required String pk,
    required bool isAccept,
  });
}
