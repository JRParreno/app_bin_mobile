import 'dart:convert';

import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:dio/dio.dart';

class GetRefreshToken {
  static Future refreshToken({required String refreshToken}) async {
    String url = '${AppConstant.apiUrl}o/token/';
    Map<String, dynamic> data = {
      'refresh_token': refreshToken,
      'grant_type': 'refresh_token',
      'client_id': AppConstant.clientId,
      'client_secret': AppConstant.clientSecret
    };
    final Dio dio = Dio();
    final userDetails = await dio.post(url, data: data);

    if (userDetails.statusCode == 400) {
      return {'statusCode': userDetails.statusCode, 'data': userDetails.data};
    }

    Map<String, dynamic> responseJson = jsonDecode(userDetails.data);
    return {
      'accessToken': responseJson['access_token'],
      'refreshToken': responseJson['refresh_token'],
      'statusCode': userDetails.statusCode,
      'surgeon': responseJson['surgeon'],
    };
  }
}
