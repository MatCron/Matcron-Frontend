import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/usecases/register.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteRegistrationBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final GetRegisterUseCase _registerUseCase;

  RemoteRegistrationBloc(this._registerUseCase)
      : super(const RemoteAuthInitial(null, null)) {
    on<RegisterUser>(onRegister);
  }

  void onRegister(RegisterUser event, Emitter<RemoteAuthState> emit) async {
    emit(RemoteAuthLoading());

    if (isValidUser(event.userRegistrationEntity!, event.confirmPassword!, emit)) {
      final dataState =
          await _registerUseCase(params: event.userRegistrationEntity);

      if (dataState is DataSuccess && dataState.data != null) {
        emit(RemoteRegistrationDone(dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(RemoteAuthException(dataState.error!));
      }
    }
  }

  bool isValidUser(UserRegistrationEntity entity, String confirmPassword,
      Emitter<RemoteAuthState> emit) {
    // Validate first and last name
    if (entity.firstName.isEmpty || entity.lastName.isEmpty) {
      emit(RemoteAuthInitial('First name and last name are required.', 'NAME'));
      return false;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(entity.email)) {
      emit(RemoteAuthInitial('Invalid email format.', 'EMAIL'));
      return false;
    }

     // Validate organisation code
    if (entity.organisationCode.isEmpty) {
      emit(RemoteAuthInitial('Organisation code is required.', 'ORGANIZATION'));
      return false;
    }


    // Validate password criteria (example: minimum 8 characters)
    if (entity.password.length < 8) {
      emit(RemoteAuthInitial(
          'Password must be at least 8 characters long.', 'PASSWORD'));
      return false;
    }

    // Check if passwords match
    if (entity.password != confirmPassword) {
      emit(RemoteAuthInitial('Passwords do not match.', 'CONFIRMPASSWORD'));
      return false;
    }
    return true;
  }
}
