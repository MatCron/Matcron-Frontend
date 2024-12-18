import 'dart:io';
import 'package:dio/dio.dart';
import 'package:matcron/app/features/type/data/data_sources/remote/type_api_service.dart';
import 'package:matcron/app/features/type/data/models/type_model.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class TypeRepositoryImpl implements TypeRepository {
  final TypeApiService _typeApiService;

  TypeRepositoryImpl(this._typeApiService);

  @override
  Future<DataState<List<MattressTypeEntity>>> getTypes() async {
    try {
      final httpResponse = await _typeApiService.getTypes();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final types = (httpResponse.data as List)
            .map((type) => TypeModel.fromJson(type))
            .toList();
        return DataSuccess(types);
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
  Future<DataState<void>> addType(MattressTypeEntity type) async {
    try {
      final httpResponse = await _typeApiService.addType(model: TypeModel.fromEntity(type));

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
  Future<DataState<void>> editType(MattressTypeEntity type) async {
    try {
      final httpResponse = await _typeApiService.editType(model: TypeModel.fromEntity(type));

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
  Future<DataState<void>> deleteType(MattressTypeEntity type) async {
    try {
      final httpResponse = await _typeApiService.deleteType(id: type.id!);

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
