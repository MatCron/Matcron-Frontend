import 'package:dio/dio.dart';
import 'package:matcron/app/features/type/data/models/type_model.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'type_api_service.g.dart';

@RestApi(baseUrl: typeBaseUrl)
abstract class TypeApiService {
  factory TypeApiService(Dio dio) = _TypeApiService;

  @GET('/types')
  Future<HttpResponse<List<TypeModel>>> getTypes();

  @POST('/types/add')
  Future<HttpResponse<void>> addType({@Body() required TypeModel model});

  @POST('/types/edit')
  Future<HttpResponse<void>> editType({@Body() required TypeModel model});

  @POST('/types/delete')
  Future<HttpResponse<void>> deleteType({@Body() required String id});
}
