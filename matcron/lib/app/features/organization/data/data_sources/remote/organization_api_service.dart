import 'package:dio/dio.dart';
import 'package:matcron/app/features/organization/data/models/organization.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'organization_api_service.g.dart';

@RestApi(baseUrl: organizationBaseUrl)
abstract class OrganizationApiService {
  factory OrganizationApiService(Dio dio) = _OrganizationApiService;
  

  @GET('/')
  Future<HttpResponse<List<OrganizationModel>>> getOrganizations({@Header('Authorization') required String token});

  @GET('/{id}')
  Future<HttpResponse<OrganizationModel>> getOrganization({@Path('id') required String id, @Header('Authorization') required String token});

  @POST('/')
  Future<HttpResponse<void>> addOrganization({@Body() required OrganizationModel model, @Header('Authorization') required String token});

  @PUT('/{id}')
  Future<HttpResponse<void>> update({@Path('id') required String id, @Body() required OrganizationModel model, @Header('Authorization') required String token});

  @DELETE('/{id}')
  Future<HttpResponse<void>> delete({@Path('id') required String id, @Header('Authorization') required String token});
}