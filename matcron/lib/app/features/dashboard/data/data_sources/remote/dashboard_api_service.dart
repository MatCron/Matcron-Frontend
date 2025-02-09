import 'package:dio/dio.dart';
import 'package:matcron/app/features/dashboard/data/models/dashboard.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'dashboard_api_service.g.dart';

@RestApi(baseUrl: dashboardAPIBaseUrl)
abstract class DashboardApiService {
  factory DashboardApiService(Dio dio) = _DashboardApiService;

  @GET('/dashboard')
  Future<HttpResponse<DashboardModel>> getDashboardInfo();
}