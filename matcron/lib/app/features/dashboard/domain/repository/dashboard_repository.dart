import 'package:matcron/app/features/dashboard/domain/entities/dashboard.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class DashboardRepository {
  Future<DataState<DashboardEntity>> getDashboardInfo();
}