import 'package:matcron/app/features/auth/domain/entities/user.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>>  login(UserLoginEntity model);
  Future<DataState<UserEntity>>  register(UserRegistrationEntity model);

}