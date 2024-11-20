import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:matcron/app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/app/features/auth/domain/usecases/login.dart';
import 'package:matcron/app/features/auth/domain/usecases/register.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/core/resources/encryption.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<AuthApiService>(
    AuthApiService(sl())
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(), sl())
  );

  // UseCases
  sl.registerSingleton<GetRegisterUseCase>(
    GetRegisterUseCase(sl())
  );

  sl.registerSingleton<GetLoginUseCase>(
    GetLoginUseCase(sl())
  );
  
  // Blocs
  sl.registerFactory<RemoteRegistrationBloc>(
    () => RemoteRegistrationBloc(sl())
  );

  sl.registerFactory<RemoteLoginBloc>(
    () => RemoteLoginBloc(sl())
  );

  //Services
  sl.registerFactory<EncryptionService>(
    () => EncryptionService()
  );
}