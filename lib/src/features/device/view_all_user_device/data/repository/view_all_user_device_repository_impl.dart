import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/device/view_all_user_device/data/repository/view_all_user_device_repository.dart';

class ViewAllUserDeviceRepositoryImpl implements ViewAllUserDeviceRepository {
  @override
  Future<List<Device>> fetchUserAllDevice(String pk) async {
    String url = '${AppConstant.apiUrl}/view-user-all-device?q=$pk';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      List<Device> tempDevices = [];

      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        tempDevices = results.map((e) => Device.fromMap(e)).toList();
      }
      return tempDevices;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
