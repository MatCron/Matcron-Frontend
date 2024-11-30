import 'dart:io';
import 'package:dio/dio.dart';
import 'package:matcron/app/features/organization/data/data_sources/remote/organization_api_service.dart';
import 'package:matcron/app/features/organization/data/models/organization.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/organization/domain/repositories/organization_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class OrganizationRepositoryImpl implements OrganizationRepository {
  final OrganizationApiService _organizationApiService;

  OrganizationRepositoryImpl(this._organizationApiService);

  @override
  Future<DataState<void>> addOrganization(OrganizationEntity entity) async {
    try {
      final httpResponse = await _organizationApiService.addOrganization(model: OrganizationModel.fromEntity(entity));

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
    try {
      final httpResponse = await _organizationApiService.delete(id: id);

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
    // TODO: implement getOrganizations
    try {
      final httpResponse = await _organizationApiService.getOrganizations();

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
  

  // @override
  // Future<DataState<void>> updateOrganization(String id) async {
  //   // TODO: implement updateOrganization
  //   try {
  //     final httpResponse = await _organizationApiService.update(id: id);

  //     if (httpResponse.response.statusCode == HttpStatus.ok) {
  //       return DataSuccess(httpResponse.data);
  //     } else {
  //       return DataFailed(
  //         DioException(
  //           error: httpResponse.response.statusMessage,
  //           response: httpResponse.response,
  //           type: DioExceptionType.badResponse,
  //           requestOptions: httpResponse.response.requestOptions, 
  //         )
  //       );
  //     }

  //   } on DioException catch(e) {
  //     return DataFailed(e);
  //   } 
  // }
  
}