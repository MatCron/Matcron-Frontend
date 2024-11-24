import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/dashboard/domain/entities/dashboard.dart';

abstract class RemoteDashboardState extends Equatable {
  final DashboardEntity ? info;
  final DioException  ? exception;

  const RemoteDashboardState({this.info, this.exception});

  @override
  List<Object> get props => [info!, exception!];
}

//start everything at 0...
class RemoteDashboardInitial extends RemoteDashboardState {
  const RemoteDashboardInitial(); // Represents the initial state
}

class RemoteDashboardLoading extends RemoteDashboardState {
  const RemoteDashboardLoading();
}

class RemoteDashboardDone extends RemoteDashboardState {
  const RemoteDashboardDone(DashboardEntity info) :super(info: info);
}

class RemoteDashboardException extends RemoteDashboardState {
  const RemoteDashboardException(DioException exception) : super(exception: exception);
}