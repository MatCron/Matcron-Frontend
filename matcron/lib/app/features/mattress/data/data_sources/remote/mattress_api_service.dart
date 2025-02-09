import 'package:dio/dio.dart';
import 'package:matcron/app/features/mattress/data/models/matress.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'mattress_api_service.g.dart';

@RestApi(baseUrl: mattressBaseUrl)
abstract class MattressApiService {
  factory MattressApiService(Dio dio) = _MattressApiService;

  @POST('/')
  Future<HttpResponse<String>> generateRfid({@Body() required MattressModel model,  @Header('Authorization') required String token});

  @GET('/{id}')
  Future<HttpResponse<MattressModel>> getMattressById({@Path('id') required String id, @Header('Authorization') required String token});

  @GET('/')
  Future<HttpResponse<List<MattressModel>>> getMattresses({@Header('Authorization') required String token});

  @PUT('/{id}')
  Future<HttpResponse<void>> updateMattress({@Path('id') required String id, @Body() required MattressModel model, @Header('Authorization') required String token});
}