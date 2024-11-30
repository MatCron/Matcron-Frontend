import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/organization/domain/usecases/get_organizations.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteOrganizationBloc extends Bloc<RemoteOrganizationEvent, RemoteOrganizationState> {
  final GetOrganizationsUseCase _organizationsUseCase;

  RemoteOrganizationBloc(this._organizationsUseCase) : super(const RemoteOrganizationsLoading()) {
    on <GetOrganizations> (onGetOrganizations);
  }

  void onGetOrganizations(GetOrganizations event, Emitter<RemoteOrganizationState> emit) async {
    final dataState = await _organizationsUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        RemoteOrganizationsDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emit(
        RemoteOrganizationsException(dataState.error!)
      );
    }
  }
}