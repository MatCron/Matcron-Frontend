import 'dart:io';

import 'package:dio/dio.dart';
import 'package:matcron/app/features/mattress_history/data/data_sources/remote/mattress_history_api_service.dart';
import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';
import 'package:matcron/app/features/mattress_history/domain/repositories/mattress_history_repository.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class MattressHistoryRepositoryImpl implements MattressHistoryRepository {
  final MattressHistoryApiService _mattressHistoryApiService;

  MattressHistoryRepositoryImpl(this._mattressHistoryApiService);

  @override
  Future<DataState<List<MattressHistoryEntity>>> getMattressHistoryById(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';

    try {
      final httpResponse = await _mattressHistoryApiService.getMattressHistory(id: id, token: token);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
      
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}