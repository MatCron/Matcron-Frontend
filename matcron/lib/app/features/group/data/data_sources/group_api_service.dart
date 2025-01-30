import 'package:dio/dio.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'group_api_service.g.dart';

@RestApi(baseUrl: groupBaseUrl)
abstract class GroupApiService {
  factory GroupApiService(Dio dio) = _GroupApiService;

  @GET('/import-preview/{id}')
  Future<HttpResponse<GroupModel>> getImportPreviewFromMattressId({@Path('id') required String id, @Header('Authorization') required String token});

  @POST('import-mattresses/{id}')
  Future <HttpResponse<void>> importMattressFromGroup({@Path('id') required String id, @Header('Authorization') required String token});


}