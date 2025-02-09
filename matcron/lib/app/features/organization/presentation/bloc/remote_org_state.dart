 import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';

abstract class RemoteOrganizationState extends Equatable {
  final List<OrganizationEntity> ? organizations;
  final OrganizationEntity ? organization;
  final DioException  ? exception;

  const RemoteOrganizationState({this.organization, this.organizations, this.exception});

  @override
  List<Object> get props {
  final propsList = <Object>[];

  if (organizations != null) propsList.add(organizations!);
  if (exception != null) propsList.add(exception!);
  if (organization != null) propsList.add(organization!);

  return propsList;
}
}

class RemoteOrganizationsLoading extends RemoteOrganizationState {
    const RemoteOrganizationsLoading();
}

class RemoteOrganizationsDone extends RemoteOrganizationState {
  const RemoteOrganizationsDone(List<OrganizationEntity> organizations) : super(organizations: organizations);
}

class RemoteOrganizationsException extends RemoteOrganizationState {
  const RemoteOrganizationsException(DioException exception) : super(exception: exception);
}
