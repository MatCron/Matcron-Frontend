import 'package:matcron/app/features/auth/data/models/user.dart';
import 'package:matcron/app/features/auth/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponseEntity{
  const LoginResponseModel({
    bool ? success,
    String ? message,
    UserModel ? data
  }) : super(user: data);

  factory LoginResponseModel.fromJson(Map<String, dynamic> map) {
    return LoginResponseModel(
      success: map["success"] ?? false,
      message: map["message"] ?? "",
      data: UserModel.fromJson(map["data"]),
    );
  }
}