class UserRegistrationEntity {
  String firstName;
  String lastName;
  String email;
  String password;
  String organisationCode;

  UserRegistrationEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.organisationCode
  });
}

class UserLoginEntity {
  String email;
  String password;
  
  UserLoginEntity({
    required this.email,
    required this.password,
  });
}