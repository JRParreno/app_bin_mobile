import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device.dart';
import 'package:app_bin_mobile/src/features/apps/data/models/device_app.dart';
import 'package:app_bin_mobile/src/features/apps/data/repository/device_repository.dart';

class DeviceRepositoryImpl extends DeviceRepository {
  @override
  Future<Device?> getUserDevice({required String deviceCode}) async {
    String url = '${AppConstant.apiUrl}/device?q=$deviceCode';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final response = Device.fromMap(results.first);
        return response;
      }
      return null;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Device> registerUserDevice({
    required String deviceCode,
    required String deviceName,
  }) async {
    const String url = '${AppConstant.apiUrl}/device-list';
    final data = {"device_name": deviceName, "device_code": deviceCode};

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
    )
        .then((value) {
      final response = Device.fromMap(value.data);

      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> syncDeviceApps(List<DeviceApp> apps) async {
    const String url = '${AppConstant.apiUrl}/device-apps';
    final tempApps = apps.map((e) => e.formData()).toList();

    final data = {
      "apps": tempApps,
    };

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
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
  Future<List<DeviceApp>> getDeviceApps(String deviceCode) async {
    final String url =
        '${AppConstant.apiUrl}/device-apps?device_code=$deviceCode&limit=100';

    return await ApiInterceptor.apiInstance()
        .get(
      url,
    )
        .then((value) {
      List<DeviceApp> deviceApps = [];
      final results = value.data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        deviceApps = results.map((e) => DeviceApp.fromMap(e)).toList();
      }
      return deviceApps;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Device?> getDeviceInfo() async {
    final currentDeviceInfo = await LocalStorage.readLocalStorage('_device');
    if (currentDeviceInfo == null) return null;

    return Device.fromJsonLocal(currentDeviceInfo);
  }
}
