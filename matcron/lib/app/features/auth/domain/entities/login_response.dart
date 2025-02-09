import 'package:matcron/app/features/auth/domain/entities/user.dart';

class LoginResponseEntity {
  final UserEntity ? user;

  const LoginResponseEntity({
    this.user
  });
}