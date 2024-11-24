import 'package:matcron/app/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    String ? id,
    String ? firstName,
    String ? lastName,
    String ? organizationId,
    String ? email,
    bool ? emailVerified,
    String ? image,
  }) : super(
        id: id ?? "",
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        organizationId: organizationId ?? "",
        email: email ?? "",
        emailVerified: emailVerified ?? false,
        image: image ?? "",
      );

  factory UserModel.fromJson(Map <String, dynamic> map) {
    return UserModel(
      id: map["userId"] ?? "",
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      organizationId: map["organizationId"] ?? "",
      email: map["email"] ?? "",
      emailVerified: map["emailVerified"] ?? false,
      image: map["image"] ?? "",
    );
  } 
}