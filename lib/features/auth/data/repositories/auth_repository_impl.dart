import 'package:flutter_dev_test/core/error/exceptions.dart';
import 'package:flutter_dev_test/core/services/storage_service.dart';
import 'package:flutter_dev_test/core/utils/totp_generator.dart';
import 'package:flutter_dev_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_dev_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final StorageService storageService;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storageService,
  });

  @override
  Future<String> getSecret() async {
    try {
      return await storageService.getSecret();
    } on CacheException {
      throw CacheException('Secret não encontrado');
    }
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final secret = await getSecret();
      final totpCode = generateTOTP(secret);
      return await remoteDataSource.login(
        username: username,
        password: password,
        totpCode: totpCode,
      );
    } on CacheException {
      rethrow;
    } on InvalidTotpCodeException catch (e) {
      throw InvalidTotpCodeException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> recoverSecret({
    required String username,
    required String password,
    required String recoveryCode,
  }) async {
    try {
      return await remoteDataSource.recoverSecret(
        username: username,
        password: password,
        code: recoveryCode,
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<void> saveSecret(String secret) async {
    return await storageService.saveSecret(secret);
  }
}
