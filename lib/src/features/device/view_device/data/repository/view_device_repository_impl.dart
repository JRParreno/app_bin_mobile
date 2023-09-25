import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/repository/view_device_repository.dart';

class ViewDeviceRepositoryImpl implements ViewDeviceRepository {
  @override
  Future<List<PairDevice>> getPairDevices() async {
    const String url = '${AppConstant.apiUrl}/my-device';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      List<PairDevice> tempDevices = [];

      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        tempDevices = results.map((e) => PairDevice.fromMap(e)).toList();
      }
      return tempDevices;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
