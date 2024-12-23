import 'dart:io';
import 'package:dio/dio.dart';
import 'package:matcron/app/features/type/data/data_sources/remote/type_api_service.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class TypeRepositoryImpl implements TypeRepository {
  final TypeApiService _typeApiService;

  TypeRepositoryImpl(this._typeApiService);

  @override
  Future<DataState<List<MattressTypeEntity>>> getTypes() async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';

    try {
      final httpResponse = await _typeApiService.getTypes(token: token);

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
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MattressTypeEntity>> getType(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';

    try {
      final httpResponse = await _typeApiService.getType(token: token, id: id);

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
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
