import 'package:dio/dio.dart';
import 'package:matcron/app/features/auth/data/models/user.dart';
import 'package:matcron/app/features/auth/data/models/user_db.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: userAPIBaseURL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;
 
  
  @POST('/login')
  Future<HttpResponse<UserModel>> login({@Body() required UserLoginDbModel model});

  @POST('/register')
  Future<HttpResponse<UserModel>> register({@Body() required UserRegistrationDbModel model});
}