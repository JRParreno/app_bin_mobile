import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> fetchProfile();
  Future<Profile> updateProfile({
    required Profile profile,
  });
}
