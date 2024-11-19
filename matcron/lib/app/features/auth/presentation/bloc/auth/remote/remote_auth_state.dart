import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/auth/domain/entities/user.dart';

abstract class RemoteAuthState extends Equatable {
  final UserEntity ? user;
  final DioException ? exception;

  const RemoteAuthState({this.user, this.exception});

  @override
  List<Object> get props => [user!, exception!];
}

class RemoteAuthInitial extends RemoteAuthState {
  const RemoteAuthInitial(); // Represents the initial state
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone(UserEntity user) :super(user: user);
}

class RemoteAuthException extends RemoteAuthState {
  const RemoteAuthException(DioException exception) : super(exception: exception);
}