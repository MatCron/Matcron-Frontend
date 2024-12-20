import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class OrganizationRepository {
  Future<DataState<List<OrganizationEntity>>> getOrganizations();
  Future<DataState<OrganizationEntity>> getOrganization(String id);
  Future<DataState<void>> addOrganization(OrganizationEntity entity);
  Future<DataState<void>> updateOrganization(OrganizationEntity entity);
  Future<DataState<void>> deleteOrganization(String id);
}