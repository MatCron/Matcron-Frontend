import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetOrganizationUseCase implements Usecase<DataState<OrganizationEntity>, String> {
  final OrganizationRepository _organizationRepository;

  GetOrganizationUseCase(this._organizationRepository);

  @override
  Future<DataState<OrganizationEntity>> call({String? params}) {
    return _organizationRepository.getOrganization(params!);
  }
}