import 'package:dio/dio.dart';
import 'package:matcron/app/features/organization/data/models/organization.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'organization_api_service.g.dart';

@RestApi(baseUrl: organizationBaseUrl)
abstract class OrganizationApiService {
  factory OrganizationApiService(Dio dio) = _OrganizationApiService;

  @GET('/organizations')
  Future<HttpResponse<List<OrganizationModel>>> getOrganizations();

  @POST('/organizations/add')
  Future<HttpResponse<void>> addOrganization({@Body() required OrganizationModel model});

  // @POST('/organizations/update')
  // Future<HttpResponse<void>> update({@Body() required String id});

  @POST('/organizations/delete')
  Future<HttpResponse<void>> delete({@Body() required String id});
}