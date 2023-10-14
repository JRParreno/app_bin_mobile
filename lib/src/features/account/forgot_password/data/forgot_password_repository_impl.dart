import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/account/forgot_password/data/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  @override
  Future<String> forgotPassowrd(String email) async {
    String url = '${AppConstant.apiUrl}/forgot-password';

    final data = {
      'email_address': email,
    };

    return await ApiInterceptor.apiInstance()
        .post(
      url,
      data: data,
    )
        .then((value) {
      return value.data['success'];
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
