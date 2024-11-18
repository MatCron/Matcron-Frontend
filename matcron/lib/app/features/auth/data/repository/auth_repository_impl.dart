import 'package:matcron/app/features/auth/domain/entities/user.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<DataState<UserEntity>> login(UserLoginEntity model) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<DataState<UserEntity>> register(UserRegistrationEntity model) {
    // TODO: implement register
    throw UnimplementedError();
  }

}