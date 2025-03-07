import 'package:dio/dio.dart';
import 'package:matcron/app/features/mattress_history/data/models/mattress_history_model.dart';
import 'package:retrofit/retrofit.dart';

part 'mattress_history_api.g.dart';

abstract class MattressHistoryApiService {
  factory MattressHistoryApiService(Dio dio) = _MattressHistoryApiService;

  @GET('/{id}/log')
  Future<HttpResponse<List<MattressHistoryModel>>> getMattressHistory({@Header('Authorization') required String token, @Path('id') required String id});
}