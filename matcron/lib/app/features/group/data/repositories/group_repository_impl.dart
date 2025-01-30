import 'dart:io';

import 'package:dio/dio.dart';
import 'package:matcron/app/features/group/data/data_sources/group_api_service.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupApiService _groupApiService;

  GroupRepositoryImpl(this._groupApiService);

  @override
  Future<DataState<GroupEntity>> getImportPreviewFromMattressId(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    
    try {
      final httpResponse = await _groupApiService.getImportPreviewFromMattressId(id: id, token: token);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions, 
          )
        );
      }
      
    } on DioException catch(e) {
      return DataFailed(e);
    }
  }
}