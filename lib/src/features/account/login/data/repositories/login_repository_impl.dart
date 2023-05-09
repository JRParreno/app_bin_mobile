import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/account/login/data/repositories/login_repository.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImpl extends LoginRepository {
  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    String url = '${AppConstant.serverUrl}/o/token/';

    Map<String, dynamic> data = {
      'username': email,
      'password': password,
      'grant_type': 'password',
      'client_id': AppConstant.clientId,
      'client_secret': AppConstant.clientSecret
    };

    return await dio.post(url, data: data).then((value) {
      return {'status': value.statusCode, 'data': value.data};
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioError;

      if (error.response != null && error.response!.data != null) {
        throw {
          'status': error.response?.statusCode ?? '400',
          'data': error.response!.data,
        };
      }

      return {
        'status': 'NA',
        'data': 'NA',
      };
    });
  }
}
