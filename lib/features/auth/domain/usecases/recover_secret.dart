import 'package:flutter_dev_test/features/auth/domain/repositories/auth_repository.dart';

class RecoverSecret {
  final AuthRepository repository;
  RecoverSecret(this.repository);

  Future<String> call({
    required String username,
    required String password,
    required String recoveryCode,
  }) async {
    return await repository.recoverSecret(
      username: username,
      password: password,
      recoveryCode: recoveryCode,
    );
  }
}
