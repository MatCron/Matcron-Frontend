import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/dashboard/domain/usecases/dashboard.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_event.dart';
import 'package:matcron/app/features/dashboard/presentation/bloc/remote_dashboard_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteDashboardBloc extends Bloc<RemoteDashboardEvent, RemoteDashboardState> {
  final GetDashboardInfoUseCase _dashboardInfoUseCase;

  RemoteDashboardBloc(this._dashboardInfoUseCase) : super(const RemoteDashboardInitial()) {
    on <GetDashboardInfo> (onGetDashboardInfo);
  }

  void onGetDashboardInfo(GetDashboardInfo event, Emitter<RemoteDashboardState> emit) async {
    //await _dashboardInfoUseCase();
    final dataState = await _dashboardInfoUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(
        RemoteDashboardDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emit(
        RemoteDashboardException(dataState.error!)
      );
    }
  }
}