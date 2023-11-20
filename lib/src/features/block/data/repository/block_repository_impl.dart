import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/block/data/repository/block_repository.dart';

class BlockRepositoryImpl extends BlockRepository {
  @override
  Future<void> updateDeviceApp({required int pk, required bool isBlock}) async {
    String url = '${AppConstant.apiUrl}/update-device-apps/$pk';

    final data = {"is_block": isBlock};

    return await ApiInterceptor.apiInstance()
        .patch(
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
}
