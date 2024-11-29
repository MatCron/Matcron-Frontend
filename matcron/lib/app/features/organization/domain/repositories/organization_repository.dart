import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class OrganizationRepository {
  Future<DataState<List<OrganizationEntity>>> getOrganizations();
  Future<DataState<void>> addOrganization(OrganizationEntity entity);
  //Future<DataState<void>> updateOrganization(String id);
  Future<DataState<void>> deleteOrganization(String id);
}