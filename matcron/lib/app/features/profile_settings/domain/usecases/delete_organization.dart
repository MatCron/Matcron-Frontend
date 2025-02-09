import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class DeleteOrganizationUseCase implements Usecase<DataState<void>, String> {
  final OrganizationRepository _organizationRepository;

  DeleteOrganizationUseCase(this._organizationRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _organizationRepository.deleteOrganization(params!);
  }
}