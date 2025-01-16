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
import 'package:matcron/app/features/mattress/data/data_sources/remote/mattress_api_service.dart';
import 'package:matcron/app/features/mattress/data/repository/mattress_repository_impl.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/app/features/mattress/domain/usecases/generate_rfid_.dart';
import 'package:matcron/app/features/mattress/domain/usecases/get_all_mattresses.dart';
import 'package:matcron/app/features/mattress/domain/usecases/update_mattress.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/organization/data/data_sources/remote/organization_api_service.dart';
import 'package:matcron/app/features/organization/data/repository/organization_repository_impl.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/app/features/organization/domain/usecases/add_organization.dart';
import 'package:matcron/app/features/organization/domain/usecases/delete_organization.dart';
import 'package:matcron/app/features/organization/domain/usecases/get_organization.dart';
import 'package:matcron/app/features/organization/domain/usecases/get_organizations.dart';
import 'package:matcron/app/features/organization/domain/usecases/update_organization.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/type/data/data_sources/remote/type_api_service.dart';
import 'package:matcron/app/features/type/data/repository/type_repository_impl.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/app/features/type/domain/usecases/get_types.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_bloc.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/encryption.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // Dio
  sl.registerSingleton<Dio>(Dio());

  //Services
  sl.registerFactory<EncryptionService>(
    () => EncryptionService()
  );

  sl.registerSingleton<AuthorizationService>(
    AuthorizationService()
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

  sl.registerSingleton<TypeApiService>(
    TypeApiService(sl())
  );

  sl.registerSingleton<MattressApiService>(
    MattressApiService(sl())
  );  

  // Repositories

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl(),sl())
  );
  
  sl.registerSingleton<DashboardRepository>(
    DashboardRepositoryImpl(sl())
  );

  sl.registerSingleton<OrganizationRepository>(
    OrganizationRepositoryImpl(sl())
  );

   sl.registerSingleton<TypeRepository>(
    TypeRepositoryImpl(sl())
  );

  sl.registerSingleton<MattressRepository>(
    MattressRepositoryImpl(sl())
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

  sl.registerSingleton<GetOrganizationUseCase>(
    GetOrganizationUseCase(sl())
  );

  sl.registerSingleton<AddOrganizationUseCase>(
    AddOrganizationUseCase(sl())
  );

  sl.registerSingleton<UpdateOrganizationUseCase>(
    UpdateOrganizationUseCase(sl())
  );

  sl.registerSingleton<DeleteOrganizationUseCase>(
    DeleteOrganizationUseCase(sl())
  );

  sl.registerSingleton<GetDashboardInfoUseCase>(
    GetDashboardInfoUseCase(sl())
  );

  sl.registerSingleton<GetTypesUseCase>(
    GetTypesUseCase(sl())
  );

  sl.registerSingleton<GetAllMattressesUsecase>(
    GetAllMattressesUsecase(sl())
  );

  sl.registerSingleton<GenerateRfidUsecase>(
    GenerateRfidUsecase(sl())
  );
  
  sl.registerSingleton<UpdateMattressUseCase>(
    UpdateMattressUseCase(sl())
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
    () => RemoteOrganizationBloc(sl(), sl(), sl(), sl())
  );

  sl.registerFactory<RemoteTypeBloc>(
    () => RemoteTypeBloc(sl())
  );

  sl.registerFactory(
    () => RemoteMattressBloc(sl(), sl(), sl(), sl())
  );
}