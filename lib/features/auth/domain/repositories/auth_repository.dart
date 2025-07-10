abstract class AuthRepository {
  Future<void> login({
    required String username,
    required String password,
  });
  Future<String> recoverSecret({
    required String username,
    required String password,
    required String recoveryCode,
  });
  Future<void> saveSecret(String secret);
  Future<String> getSecret();
}
