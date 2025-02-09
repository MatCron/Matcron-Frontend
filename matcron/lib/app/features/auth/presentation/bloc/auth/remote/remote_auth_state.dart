import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/auth/domain/entities/registration_response.dart';
import 'package:matcron/app/features/auth/domain/entities/user.dart';

abstract class RemoteAuthState extends Equatable {
  final UserEntity? user;
  final DioException? exception;
  final RegistrationResponseEntity? reg;
  final String? errorMessage;
  final String? errorType;

  const RemoteAuthState({this.user, this.exception, this.reg, this.errorMessage, this.errorType});

  @override
  List<Object?> get props => [user, exception, reg];
}


class RemoteAuthInitial extends RemoteAuthState {
  const RemoteAuthInitial(String? errorMessage, String? errorType) : super(errorMessage: errorMessage, errorType: errorType); // Represents the initial state
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone(UserEntity? user) :super(user: user);
}

class RemoteRegistrationDone extends RemoteAuthState {
  const RemoteRegistrationDone(RegistrationResponseEntity reg) : super(reg: reg);
}

class RemoteAuthException extends RemoteAuthState {
  const RemoteAuthException(DioException exception) : super(exception: exception);
}