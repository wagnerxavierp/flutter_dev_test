import 'package:flutter_dev_test/features/auth/domain/repositories/auth_repository.dart';

class GetSecret {
  final AuthRepository repository;
  GetSecret(this.repository);

  Future<String> call() async {
    return await repository.getSecret();
  }
}
