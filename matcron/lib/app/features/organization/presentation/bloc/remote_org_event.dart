import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';

abstract class RemoteOrganizationEvent extends Equatable {
  final List<OrganizationEntity> ? organizations;
  final OrganizationEntity ? organization;
  final String ? id;
  const RemoteOrganizationEvent({this.organizations, this.organization, this.id});

  @override
  List<Object> get props => [organizations!];
}

class GetOrganizations extends RemoteOrganizationEvent {
  const GetOrganizations();
}

class GetOrganization extends RemoteOrganizationEvent {
  const GetOrganization(String id) : super(id: id);
}

class AddOrganization extends RemoteOrganizationEvent {
  const AddOrganization(OrganizationEntity entity) : super(organization: entity);
}

class UpdateOrganization extends RemoteOrganizationEvent {
  const UpdateOrganization(OrganizationEntity entity) : super(organization: entity);
}

class DeleteOrganization extends RemoteOrganizationEvent {
  const DeleteOrganization(String id) : super(id: id);
}

