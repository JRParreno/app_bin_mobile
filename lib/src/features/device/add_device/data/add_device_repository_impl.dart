import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/device/add_device/data/add_device_repository.dart';
import 'package:dio/dio.dart';

class AddDeviceRepositoryImpl implements AddDeviceRepository {
  final Dio dio = Dio();

  @override
  Future<String> addDevice(String email) async {
    String url = '${AppConstant.apiUrl}/add-device';

    final data = {
      "email": email,
    };

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
    )
        .then((value) {
      return value.data['message'];
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
