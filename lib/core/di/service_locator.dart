import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dev_test/core/services/storage_service.dart';
import 'package:flutter_dev_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_dev_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_dev_test/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/get_secret.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/login.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/recover_secret.dart';
import 'package:flutter_dev_test/features/auth/domain/usecases/save_secret.dart';
import 'package:flutter_dev_test/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerLazySingleton<StorageService>(
    () => StorageService(sl<FlutterSecureStorage>()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      storageService: sl<StorageService>(),
    ),
  );

  sl.registerLazySingleton(() => Login(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RecoverSecret(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetSecret(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SaveSecret(sl<AuthRepository>()));

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl<Login>(),
      recoverSecretUseCase: sl<RecoverSecret>(),
      getSecretUseCase: sl<GetSecret>(),
      saveSecretUseCase: sl<SaveSecret>(),
    ),
  );
}
