class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class InvalidTotpCodeException implements Exception {
  final String message;
  InvalidTotpCodeException(this.message);
}
