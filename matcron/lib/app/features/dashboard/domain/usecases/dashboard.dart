import 'package:matcron/app/features/dashboard/domain/entities/dashboard.dart';
import 'package:matcron/app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetDashboardInfoUseCase implements Usecase<DataState<DashboardEntity>, void> {
  final DashboardRepository _dashboardRepository;

  GetDashboardInfoUseCase(this._dashboardRepository);

  @override
  Future<DataState<DashboardEntity>> call({void params}) {
    return _dashboardRepository.getDashboardInfo();
  }
  
  
}