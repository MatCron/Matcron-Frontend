import 'package:dio/dio.dart';
import 'package:matcron/app/features/type/data/models/type_model.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'type_api_service.g.dart';

@RestApi(baseUrl: typeBaseUrl)
abstract class TypeApiService {
  factory TypeApiService(Dio dio) = _TypeApiService;

  @GET('/summaries')
  Future<HttpResponse<List<TypeModel>>> getTypes({@Header('Authorization') required String token});

  @GET('/{id}')
  Future<HttpResponse<TypeModel>> getType(
      {@Header('Authorization') required String token, @Path('id') required String id});

  @POST('/')
  Future<HttpResponse<void>> addType({@Body() required TypeModel model, @Header('Authorization') required String token});
}
