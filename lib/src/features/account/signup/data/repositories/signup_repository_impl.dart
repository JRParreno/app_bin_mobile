import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/account/signup/data/models/signup.dart';
import 'package:app_bin_mobile/src/features/account/signup/data/repositories/signup_repository.dart';
import 'package:dio/dio.dart';

class SignupImpl extends SignupRepository {
  final Dio dio = Dio();

  @override
  Future<Map<String, dynamic>> register(Signup signup) async {
    String url = '${AppConstant.apiUrl}/register';

    final data = {
      "email": signup.email,
      "first_name": signup.firstName,
      "last_name": signup.lastName,
      "password": signup.password,
      "confirm_password": signup.confirmPassword,
      "is_parent": signup.isParent,
    };

    return await dio.post(url, data: data).then((value) {
      return {'status': value.statusCode, 'data': value.data};
    }).onError((Response<dynamic> error, stackTrace) {
      throw {
        'status': error.statusCode.toString(),
        'data': error.data,
      };
    }).catchError((onError) {
      final error = onError as DioException;

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
