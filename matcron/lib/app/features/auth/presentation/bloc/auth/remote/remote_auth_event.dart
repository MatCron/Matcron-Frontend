import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';

abstract class RemoteAuthEvent extends Equatable {
  final UserLoginEntity ? userLoginEntity;
  final UserRegistrationEntity ? userRegistrationEntity;

  const RemoteAuthEvent({this.userLoginEntity, this.userRegistrationEntity});

  @override
  List<Object> get props => [userLoginEntity!, userRegistrationEntity!];
}