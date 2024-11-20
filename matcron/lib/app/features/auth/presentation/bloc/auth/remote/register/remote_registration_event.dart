import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';

class RegisterUser extends RemoteAuthEvent {
  const RegisterUser(UserRegistrationEntity userRegistrationEntity) :  super(userRegistrationEntity: userRegistrationEntity);
}