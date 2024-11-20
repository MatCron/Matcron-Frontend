import 'package:matcron/app/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    int ? id,
    String ? firstName,
    String ? lastName,
    int ? organizationId,
    String ? email,
    bool ? emailVerified,
    String ? image,
  });

  factory UserModel.fromJson(Map <String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      organizationId: map["organizationId"] ?? "",
      email: map["email"] ?? "",
      emailVerified: map["emailVerified"] ?? "",
      image: map["image"] ?? "",
    );
  } 
}