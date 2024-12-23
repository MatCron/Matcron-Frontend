import 'dart:io';

import 'package:dio/dio.dart';
import 'package:matcron/app/features/mattress/data/data_sources/remote/mattress_api_service.dart';
import 'package:matcron/app/features/mattress/data/models/matress.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class MattressRepositoryImpl implements MattressRepository {
  final MattressApiService _mattressApiService;

  MattressRepositoryImpl(this._mattressApiService);

  @override
  Future<DataState<String>> generateRfid(MattressEntity entity) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _mattressApiService.generateRfid(model: MattressModel.fromEntity(entity) ,token: token);

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

  @override
  Future<DataState<MattressEntity>> getMattressById(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _mattressApiService.getMattressById(id: id, token: token);

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

    @override
    Future<DataState<List<MattressEntity>>> getMattresses() async {
      final String token = 'Bearer ${await AuthorizationService().getToken()}';
      try {
        final httpResponse = await _mattressApiService.getMattresses(token: token);

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