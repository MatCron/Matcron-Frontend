import 'dart:io';

import 'package:dio/dio.dart';
import 'package:matcron/app/features/group/data/data_sources/group_api_service.dart';
import 'package:matcron/app/features/group/data/models/group.dart';
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

  @override
  Future<DataState<void>> importMattressFromGroup(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    
    try {
      final httpResponse = await _groupApiService.importMattressFromGroup(id: id, token: token);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(null);
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
  Future<DataState<List<GroupEntity>>> getGroups(int status) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    
    try {
      final httpResponse = await _groupApiService.getGroups(groupStatus: status, token: token);

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
  Future<DataState<GroupEntity>> createGroup(CreateGroupModel model) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    
    try {
      final httpResponse = await _groupApiService.createGroup(model: model, token: token);

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
  Future<DataState<void>> transferOut(String uid) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    
    try {
      final httpResponse = await _groupApiService.transferOut(id: uid, token: token);

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