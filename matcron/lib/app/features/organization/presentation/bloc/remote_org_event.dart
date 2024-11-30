import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';

abstract class RemoteOrganizationEvent extends Equatable {
  final List<OrganizationEntity> ? organizations;
  const RemoteOrganizationEvent({this.organizations});

  @override
  List<Object> get props => [organizations!];
}

class GetOrganizations extends RemoteOrganizationEvent {
  const GetOrganizations();
}

class AddOrganization extends RemoteOrganizationEvent {
  const AddOrganization(OrganizationEntity entity);
}

class DeleteOrganization extends RemoteOrganizationEvent {
  const DeleteOrganization(String id);
}

