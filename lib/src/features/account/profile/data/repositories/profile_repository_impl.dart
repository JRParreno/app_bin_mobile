import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/repositories/profile_repository.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<Profile> fetchProfile() async {
    const String url = '${AppConstant.apiUrl}/profile';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final response = Profile.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    const String url = '${AppConstant.apiUrl}/change-password';

    final data = {"old_password": oldPassword, "new_password": newPassword};

    await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    const String url = '${AppConstant.apiUrl}/profile';

    final data = {
      "user": {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
      },
    };

    return await ApiInterceptor.apiInstance()
        .patch(url, data: data)
        .then((value) {
      final response = Profile.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<String> uploadPhoto(
      {required String pk, required String imagePath}) async {
    String url = '${AppConstant.apiUrl}/upload-photo/$pk';
    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "profile_photo": await MultipartFile.fromFile(imagePath,
            filename: '$dateToday - ${imagePath.split('/').last}'),
      },
    );

    return await ApiInterceptor.apiInstance()
        .put(
      url,
      data: data,
      options: Options(
        contentType: "multipart/form-data",
      ),
    )
        .then((value) {
      return value.data['profile_photo'];
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
