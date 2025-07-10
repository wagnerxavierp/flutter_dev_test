import 'package:flutter_dev_test/core/error/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const cachedTotpSecret = 'cached_totp_secret';

class StorageService {
  final FlutterSecureStorage secureStorage;

  StorageService(this.secureStorage);

  Future<void> saveSecret(String secret) async {
    await secureStorage.write(key: cachedTotpSecret, value: secret);
  }

  Future<String> getSecret() async {
    final secret = await secureStorage.read(key: cachedTotpSecret);
    if (secret != null) {
      return secret;
    } else {
      throw CacheException('Nenhum secret encontrado no cache.');
    }
  }
}
