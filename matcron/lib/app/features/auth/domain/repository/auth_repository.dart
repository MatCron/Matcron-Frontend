import 'package:matcron/app/features/auth/data/models/user_db.dart';
import 'package:matcron/app/features/auth/domain/entities/user.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>>  login(UserLoginDbModel model);
  Future<DataState<UserEntity>>  register(UserRegistrationDbModel model);

}