abstract class LoginRepository {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
}
