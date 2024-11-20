import 'dart:io';

import 'package:dio/dio.dart';
import 'package:matcron/app/features/auth/data/data_sources/remote/auth_api_service.dart';
import 'package:matcron/app/features/auth/data/models/user.dart';
import 'package:matcron/app/features/auth/data/models/user_db.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<UserModel>> login(UserLoginEntity entity) async {
    try {
      final httpResponse = await _authApiService.login(model: UserLoginDbModel.fromEntity(entity));

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
  Future<DataState<UserModel>> register(UserRegistrationEntity entity) async{
    try {
      final httpResponse = await _authApiService.register(model: UserRegistrationDbModel.fromEntity(entity));

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