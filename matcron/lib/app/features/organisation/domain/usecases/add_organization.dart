import 'package:matcron/app/features/organisation/domain/entities/organization.dart';
import 'package:matcron/app/features/organisation/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class AddOrganizationUseCase implements Usecase<DataState<void>, OrganizationEntity> {
  final OrganizationRepository _organizationRepository;

  AddOrganizationUseCase(this._organizationRepository);

  @override
  Future<DataState<void>> call({OrganizationEntity? params}) {
    return _organizationRepository.addOrganization(params!);
  }
}