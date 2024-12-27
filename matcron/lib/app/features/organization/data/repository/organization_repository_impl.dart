import 'dart:io';
import 'package:dio/dio.dart';
import 'package:matcron/app/features/organization/data/data_sources/remote/organization_api_service.dart';
import 'package:matcron/app/features/organization/data/models/organization.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/data_state.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationApiService _organizationApiService;

  OrganizationRepositoryImpl(this._organizationApiService);

  @override
  Future<DataState<void>> addOrganization(OrganizationEntity entity) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _organizationApiService.addOrganization(model: OrganizationModel.fromEntity(entity), token: token);

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
  Future<DataState<void>> deleteOrganization(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _organizationApiService.delete(id: id, token: token);

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
  Future<DataState<List<OrganizationEntity>>> getOrganizations() async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    // TODO: implement getOrganizations
    try {
      final httpResponse = await _organizationApiService.getOrganizations(token: token);

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
      return  DataFailed(e);
    } 
  }
  

  @override
  Future<DataState<void>> updateOrganization(OrganizationEntity entity) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _organizationApiService.update(id: entity.id!, model: OrganizationModel.fromEntity(entity), token: token);

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
  Future<DataState<OrganizationEntity>> getOrganization(String id) async {
    final String token = 'Bearer ${await AuthorizationService().getToken()}';
    try {
      final httpResponse = await _organizationApiService.getOrganization(id: id, token: token);

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