import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/organization/domain/usecases/add_organization.dart';
import 'package:matcron/app/features/organization/domain/usecases/delete_organization.dart';
import 'package:matcron/app/features/organization/domain/usecases/get_organizations.dart';
import 'package:matcron/app/features/organization/domain/usecases/update_organization.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteOrganizationBloc
    extends Bloc<RemoteOrganizationEvent, RemoteOrganizationState> {
  final GetOrganizationsUseCase _organizationsUseCase;
  final AddOrganizationUseCase _addOrganizationUseCase;
  final DeleteOrganizationUseCase _deleteOrganizationUseCase;
  final UpdateOrganizationUseCase _updateOrganizationUseCase;

  RemoteOrganizationBloc(
      this._organizationsUseCase,
      this._addOrganizationUseCase,
      this._deleteOrganizationUseCase,
      this._updateOrganizationUseCase)
      : super(const RemoteOrganizationsLoading()) {
    on<GetOrganizations>(onGetOrganizations);
    on<AddOrganization>(onAddOrganization);
    on<DeleteOrganization>(onDeleteOrganization);
    on<UpdateOrganization>(onUpdateOrganization);
  }

  void onGetOrganizations(
      GetOrganizations event, Emitter<RemoteOrganizationState> emit) async {
    final dataState = await _organizationsUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteOrganizationsDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteOrganizationsException(dataState.error!));
    }
  }

  void onUpdateOrganization(
      UpdateOrganization event, Emitter<RemoteOrganizationState> emit) async {
    emit(RemoteOrganizationsLoading());

    final dataState =
        await _updateOrganizationUseCase(params: event.organization);
    final organizations = await _organizationsUseCase();

    if (dataState is DataSuccess) {
      emit(RemoteOrganizationsDone(organizations.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteOrganizationsException(dataState.error!));
    }
  }

  void onAddOrganization(
      AddOrganization event, Emitter<RemoteOrganizationState> emit) async {
    final dataState = await _addOrganizationUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteOrganizationsDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteOrganizationsException(dataState.error!));
    }
  }

  void onDeleteOrganization(
      DeleteOrganization event, Emitter<RemoteOrganizationState> emit) async {
    emit(RemoteOrganizationsLoading());

    final dataState = await _deleteOrganizationUseCase(params: event.id);

    final organizations = await _organizationsUseCase();

    if (dataState is DataSuccess) {
      emit(RemoteOrganizationsDone(organizations.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteOrganizationsException(dataState.error!));
    }
  }
}
