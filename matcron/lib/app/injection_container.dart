import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:matcron/app/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:matcron/app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/app/features/auth/domain/usecases/login.dart';
import 'package:matcron/app/features/auth/domain/usecases/register.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/dashboard/data/data_sources/remote/dashboard_api_service.dart';
import 'package:matcron/app/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:matcron/app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:matcron/app/features/dashboard/domain/usecases/dashboard.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_bloc.dart';
import 'package:matcron/app/features/organization/data/data_sources/remote/organization_api_service.dart';
import 'package:matcron/app/features/organization/data/repository/organization_repository_impl.dart';
import 'package:matcron/app/features/organization/domain/usecases/get_organizations.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/core/resources/encryption.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  //Services
  sl.registerFactory<EncryptionService>(
    () => EncryptionService()
  );

  sl.registerSingleton<AuthApiService>(
    AuthApiService(sl())
  );

  sl.registerSingleton<DashboardApiService>(
    DashboardApiService(sl())
  );

  sl.registerSingleton<OrganizationApiService>(
    OrganizationApiService(sl())
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(),sl())
  );
  
  sl.registerSingleton<DashboardRepository>(
    DashboardRepositoryImpl(sl())
  );

  sl.registerSingleton<OrganizationRepositoryImpl>(
    OrganizationRepositoryImpl(sl())
  );

  // UseCases
  sl.registerSingleton<GetRegisterUseCase>(
    GetRegisterUseCase(sl())
  );

  sl.registerSingleton<GetLoginUseCase>(
    GetLoginUseCase(sl())
  );

  sl.registerSingleton<GetOrganizationsUseCase>(
    GetOrganizationsUseCase(sl())
  );

  sl.registerSingleton<GetDashboardInfoUseCase>(
    GetDashboardInfoUseCase(sl())
  );
  
  // Blocs
  sl.registerFactory<RemoteRegistrationBloc>(
    () => RemoteRegistrationBloc(sl())
  );

  sl.registerFactory<RemoteLoginBloc>(
    () => RemoteLoginBloc(sl())
  );

  sl.registerFactory<RemoteDashboardBloc>(
    () => RemoteDashboardBloc(sl())
  );

  sl.registerFactory<RemoteOrganizationBloc>(
    () => RemoteOrganizationBloc(sl())
  );
}