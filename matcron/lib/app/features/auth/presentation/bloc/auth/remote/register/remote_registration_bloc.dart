import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/usecases/register.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteRegistrationBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {

  final GetRegisterUseCase _registerUseCase;
  

  RemoteRegistrationBloc(this._registerUseCase) : super(const RemoteAuthLoading()) {
    on <Register> (onRegister);
  }

  void onRegister(Register event, Emitter<RemoteAuthState> emit) async {
    final dataState = await _registerUseCase();

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