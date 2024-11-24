import 'dart:io';
import 'package:dio/dio.dart';
import 'package:matcron/app/features/dashboard/data/data_sources/remote/dashboard_api_service.dart';
import 'package:matcron/app/features/dashboard/data/models/dashboard.dart';
import 'package:matcron/app/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService _dashboardApiService;

  DashboardRepositoryImpl(this._dashboardApiService);

  @override
  Future<DataState<DashboardModel>> getDashboardInfo() async {
    try {
      final httpResponse = await _dashboardApiService.getDashboardInfo();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions, 
          )
        );
      }

    } on DioException catch(e) {
      return DataFailed(e);
    } 
  }
  
}