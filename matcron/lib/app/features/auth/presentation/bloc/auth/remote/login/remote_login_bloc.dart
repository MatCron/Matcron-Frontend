import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/usecases/login.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteLoginBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {

  final GetLoginUseCase _loginUseCase;
  

  RemoteLoginBloc(this._loginUseCase) : super(const RemoteAuthInitial()) {
    on <Login> (onLogin);
  }

  void onLogin(Login event, Emitter<RemoteAuthState> emit) async {
    await _loginUseCase(params: event.userLoginEntity);
    final dataState = await _loginUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        RemoteAuthDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emit(
        RemoteAuthException(dataState.error!)
      );
    }
  }
}