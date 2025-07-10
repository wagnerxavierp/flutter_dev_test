part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthSecretMissing extends AuthState {}

class AuthSecretRecoverySuccess extends AuthState {}

class AuthTotpInvalid extends AuthState {
  final String message;

  const AuthTotpInvalid(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
