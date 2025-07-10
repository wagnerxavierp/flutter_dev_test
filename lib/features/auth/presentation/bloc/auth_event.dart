part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class RecoveryRequested extends AuthEvent {
  final String username;
  final String password;
  final String recoveryCode;

  const RecoveryRequested(
      {required this.username,
      required this.password,
      required this.recoveryCode});

  @override
  List<Object> get props => [username, password, recoveryCode];
}

class LogoutRequested extends AuthEvent {}
