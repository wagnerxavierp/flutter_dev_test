import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dev_test/core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<void> login({
    required String username,
    required String password,
    required String totpCode,
  });
  Future<String> recoverSecret({
    required String username,
    required String password,
    required String code,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String _baseUrl = 'http://127.0.0.1:5000';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<void> login({
    required String username,
    required String password,
    required String totpCode,
  }) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'totp_code': totpCode,
      }),
    );

    if (response.statusCode != 200) {
      final message =
          json.decode(response.body)['message'] ?? 'Falha na autenticação';
      switch (message) {
        case 'Invalid TOTP code':
          throw InvalidTotpCodeException('Código TOTP inválido');
        case 'Invalid credentials':
          throw ServerException('Credenciais inválidas');
        default:
          throw ServerException(message);
      }
    }
  }

  @override
  Future<String> recoverSecret({
    required String username,
    required String password,
    required String code,
  }) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/auth/recovery-secret'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['totp_secret'];
    } else {
      final message = json.decode(response.body)['message'] ??
          'Falha na recuperação do secret';
      switch (message) {
        case 'Invalid recovery code':
          throw ServerException('Código de recuperação inválido');
        case 'Invalid password':
          throw ServerException('Senha inválida');
        case 'User not found':
          throw ServerException('Usuário não encontrado');
        default:
          throw ServerException(message);
      }
    }
  }
}
