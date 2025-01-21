import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetOrganizationsUseCase implements Usecase<DataState<List<OrganizationEntity>>, void> {
  final OrganizationRepository _organizationRepository;

  GetOrganizationsUseCase(this._organizationRepository);

  @override
  Future<DataState<List<OrganizationEntity>>> call({void params}) {
    return _organizationRepository.getOrganizations();
  }
}