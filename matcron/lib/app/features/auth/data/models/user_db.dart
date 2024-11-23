import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';

class UserRegistrationDbModel extends UserRegistrationEntity {
  UserRegistrationDbModel({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? organisationCode,
  }) : super(
          firstName: firstName ?? '',
          lastName: lastName ?? '',
          email: email ?? '',
          password: password ?? '',
          organisationCode: organisationCode ?? '',
        );

  // Convert JSON to Model
  factory UserRegistrationDbModel.fromJson(Map<String, dynamic> map) {
    return UserRegistrationDbModel(
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      organisationCode: map['organisationCode'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'organisationCode': organisationCode
    };
  }

  // Create Model from Entity
  factory UserRegistrationDbModel.fromEntity(UserRegistrationEntity entity) {
    return UserRegistrationDbModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      organisationCode: entity.organisationCode,
    );
  }
}

class UserLoginDbModel extends UserLoginEntity {
  UserLoginDbModel({
    String? email,
    String? password,
  }) : super(
          email: email ?? '',
          password: password ?? '',
        );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Convert JSON to Model
  factory UserLoginDbModel.fromJson(Map<String, dynamic> map) {
    return UserLoginDbModel(
      email: map['email'] ?? "",
      password: map['password'] ?? "",
    );
  }

  // Create Model from Entity
  factory UserLoginDbModel.fromEntity(UserLoginEntity entity) {
    return UserLoginDbModel(
      email: entity.email,
      password: entity.password,
    );
  }
}
