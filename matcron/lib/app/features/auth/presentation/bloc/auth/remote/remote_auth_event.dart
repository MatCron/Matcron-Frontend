import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';

abstract class RemoteAuthEvent extends Equatable {
  final UserLoginEntity? userLoginEntity;
  final UserRegistrationEntity? userRegistrationEntity;
  final String? confirmPassword;

  const RemoteAuthEvent({this.userLoginEntity, this.userRegistrationEntity, this.confirmPassword});

  @override
  List<Object?> get props => [userLoginEntity, userRegistrationEntity, confirmPassword];
}
