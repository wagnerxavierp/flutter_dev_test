import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dev_test/core/error/exceptions.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/get_secret.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/login.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/recover_secret.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/save_secret.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;
  final RecoverSecret recoverSecretUseCase;
  final GetSecret getSecretUseCase;
  final SaveSecret saveSecretUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.recoverSecretUseCase,
    required this.getSecretUseCase,
    required this.saveSecretUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RecoveryRequested>(_onRecoveryRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await loginUseCase(
        username: event.username,
        password: event.password,
      );
      emit(AuthSuccess());
    } on CacheException {
      emit(AuthSecretMissing());
    } on InvalidTotpCodeException catch (e) {
      emit(AuthTotpInvalid(e.message));
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Ocorreu um erro inesperado: ${e.toString()}'));
    }
  }

  Future<void> _onRecoveryRequested(
    RecoveryRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final secret = await recoverSecretUseCase(
        username: event.username,
        password: event.password,
        recoveryCode: event.recoveryCode,
      );
      await saveSecretUseCase(secret);
      emit(AuthSecretRecoverySuccess());
    } on ServerException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Ocorreu um erro inesperado: ${e.toString()}'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
