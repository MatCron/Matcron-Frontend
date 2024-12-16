import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/usecases/login.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteLoginBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final GetLoginUseCase _loginUseCase;

  RemoteLoginBloc(this._loginUseCase) : super(RemoteAuthInitial(null, null)) {
    on<Login>(onLogin);
  }

  void onLogin(Login event, Emitter<RemoteAuthState> emit) async {
    emit(RemoteAuthLoading());

    if (isValidUser(event.userLoginEntity!, emit)) {
      final dataState = await _loginUseCase(params: event.userLoginEntity);
      //store token
      if (dataState is DataSuccess && dataState.data != null) {
        final AuthorizationService authorizationService = AuthorizationService();
        var token = dataState.data?.user?.token;
        authorizationService.saveToken(token!);
        
        emit(RemoteAuthDone(dataState.data?.user));
      }

      if (dataState is DataFailed) {
        emit(RemoteAuthException(dataState.error!));
      }
    }
  }

  bool isValidUser(UserLoginEntity entity, Emitter<RemoteAuthState> emit) {
    if (entity.email.isEmpty) {
      emit(RemoteAuthInitial('Invalid email format', 'EMAIL'));
      return false;
    }

    if (entity.password.isEmpty) {
      emit(RemoteAuthInitial('Password cannot be empty', 'PASSWORD'));
      return false;
    }

    return true;
  }
}
