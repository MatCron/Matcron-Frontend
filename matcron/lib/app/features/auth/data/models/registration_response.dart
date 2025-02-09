import 'package:matcron/app/features/auth/domain/entities/registration_response.dart';

class RegistrationResponseModel extends RegistrationResponseEntity {
  const RegistrationResponseModel({
    bool ? success,
    String ? message,
    String ? userId,
  }) : super(message: message ?? "");

  
  factory RegistrationResponseModel.fromJson(Map<String, dynamic> map) {
    return RegistrationResponseModel(
      success: map["success"] ?? false,
      message: map["message"] ?? "",
      userId: map["userId"] ?? ""
    );
  }
}