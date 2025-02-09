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
    String ? token
  }) : super(
        id: id ?? "",
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        organizationId: organizationId ?? "",
        email: email ?? "",
        emailVerified: emailVerified ?? false,
        image: image ?? "",
        token: token ?? "",
      );

  factory UserModel.fromJson(Map <String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      organizationId: map["orgId"] ?? "",
      email: map["email"] ?? "",
      emailVerified: map["emailVerified"] == 0 ? false : true,
      image: map["profilePicture"] ?? "",
      token: map["token"] ?? ""
    );
  } 
}