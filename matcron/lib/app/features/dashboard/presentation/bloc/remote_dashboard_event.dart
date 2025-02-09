import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/dashboard/domain/entities/dashboard.dart';

abstract class RemoteDashboardEvent extends Equatable {
  final DashboardEntity ? info;
  const RemoteDashboardEvent({this.info});

  @override
  List<Object> get props => [info!];
}

class GetDashboardInfo extends RemoteDashboardEvent {
  const GetDashboardInfo();
}