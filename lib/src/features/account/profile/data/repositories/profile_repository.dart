import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> fetchProfile();
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  });
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<String> uploadPhoto({
    required String pk,
    required String imagePath,
  });
}
