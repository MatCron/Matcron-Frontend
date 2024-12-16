import 'package:matcron/app/features/auth/domain/entities/login_response.dart';
import 'package:matcron/app/features/auth/domain/entities/registration_response.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponseEntity>>  login(UserLoginEntity entity);
  Future<DataState<RegistrationResponseEntity>>  register(UserRegistrationEntity entity);

}