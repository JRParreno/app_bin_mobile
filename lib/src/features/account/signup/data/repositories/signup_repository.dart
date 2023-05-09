import 'package:app_bin_mobile/src/features/account/signup/data/models/signup.dart';

abstract class SignupRepository {
  Future<Map<String, dynamic>> register(Signup signup);
}
