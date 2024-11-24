import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String ? id;
  final String ? firstName;
  final String ? lastName;
  final String ? organizationId;
  final String ? email;
  final bool ? emailVerified;
  final String ? image;


  const UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.organizationId,
    this.email,
    this.emailVerified,
    this.image,
  });
  
  @override
  List<Object?> get props {
    return [
      id,
      organizationId,
      email,
      emailVerified,
      image,
      firstName,
      lastName
    ];
  }
}