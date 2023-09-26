import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/device/request_device/data/repository/request_device_repository.dart';
import 'package:app_bin_mobile/src/features/device/view_device/data/models/pair_device.dart';

class RequestDeviceRepositoryImpl implements RequestDeviceRepository {
  @override
  Future<List<PairDevice>> getRequestPairDevices() async {
    const String url = '${AppConstant.apiUrl}/my-device?q=request_device';
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

  @override
  Future<PairDevice> updateRequestPairDevices({
    required String pk,
    required bool isAccept,
  }) async {
    String url = '${AppConstant.apiUrl}/update-device/$pk';

    final data = {"pair_status": isAccept ? "ACCEPTED" : "REJECTED"};

    return await ApiInterceptor.apiInstance()
        .put(
      url,
      data: data,
    )
        .then((value) {
      return PairDevice.fromMap(value.data);
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
