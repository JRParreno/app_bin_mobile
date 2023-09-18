import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/account/forgot_password/data/repositories/forgot_password_repository.dart';
import 'package:dio/dio.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final Dio dio = Dio();

  @override
  Future<void> forgotPassword(String emailAddress) async {
    String url = '${AppConstant.apiUrl}/forgot-password';

    final data = {
      "email": emailAddress,
    };

    return await dio.post(url, data: data).then((value) {
      return;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
