import 'package:flutter_dev_test/features/auth/domain/repositories/auth_repository.dart';

class SaveSecret {
  final AuthRepository repository;
  SaveSecret(this.repository);

  Future<void> call(String secret) async {
    return await repository.saveSecret(secret);
  }
}
