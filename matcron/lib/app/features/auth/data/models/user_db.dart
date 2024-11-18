import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';

class UserRegistrationDbModel extends UserRegistrationEntity {
  UserRegistrationDbModel({
    String ? firstName,
    String ? lastName,
    String ? email,
    String ? password,
    String ? organisationCode,
  }) : super(firstName: '', lastName: '', email: '', password: '', organisationCode: '');
  
  factory UserRegistrationDbModel.toJson(Map <String, dynamic> map) { 
    return UserRegistrationDbModel(
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      organisationCode: map['organisationCode'] ?? "",
    );
  }
}

class UserLoginDbModel extends UserLoginEntity {
  UserLoginDbModel({
    String ? email,
    String ? password,
  }) : super(email: '', password: '');
  
  factory UserLoginDbModel.toJson(Map <String, dynamic> map) { 
    return UserLoginDbModel(
      email: map['email'] ?? "",
      password: map['password'] ?? "",
    );
  }
}