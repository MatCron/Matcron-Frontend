import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int ? id;
  final String ? firstName;
  final String ? lastName;
  final int ? organizationId;
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