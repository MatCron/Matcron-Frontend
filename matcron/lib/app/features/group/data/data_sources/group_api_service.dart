import 'package:dio/dio.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';
part 'group_api_service.g.dart';

@RestApi(baseUrl: groupBaseUrl)
abstract class GroupApiService {
  factory GroupApiService(Dio dio) = _GroupApiService;

  @GET('/import-preview/{id}')
  Future<HttpResponse<GroupModel>> getImportPreviewFromMattressId({@Path('id') required String id, @Header('Authorization') required String token});

  @POST('/import-mattresses/{id}')
  Future <HttpResponse<void>> importMattressFromGroup({@Path('id') required String id, @Header('Authorization') required String token});

  @POST('/group-by-status')
  Future<HttpResponse<List<GroupModel>>> getGroups({@Body() required int groupStatus, @Header('Authorization') required String token});

  @POST('/add')
  Future<HttpResponse<GroupModel>> createGroup({@Body() required CreateGroupModel model, @Header('Authorization') required String token});

  @GET('/{id}')
  Future<HttpResponse<GroupWithMattressesDto>> getGroupById({@Path('id') required String id, @Header('Authorization') required String token});

  @POST('/transfer-out/{id}')
  Future <HttpResponse<void>> transferOut({@Path('id') required String id, @Header('Authorization') required String token});
}