import 'package:matcron/app/features/organisation/domain/entities/organization.dart';

class OrganizationModel extends OrganizationEntity {
  OrganizationModel({
    super.id,
    super.name,
    super.type,
    super.email,
    super.registrationNumber,
    super.description,
    super.postalAddress,
    super.normalAddress,
    super.logo,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      type: map['organisationType'] is int ? map['organisationType'] : int.tryParse(map['organisationType'].toString()) ?? 0,
      email: map['email'] ?? "",
      registrationNumber: map['registrationNo'] ?? "",
      description: map['description'] ?? "",
      postalAddress: map['postalAddress'] ?? "",
      normalAddress: map['normalAddress'] ?? "",
      logo: map['logo'] ?? "",  // Assuming 'logo' can be a URL or file path string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organisationType': type,
      'email': email,
      'registrationNo': registrationNumber,
      'description': description,
      'postalAddress': postalAddress,
      'normalAddress': normalAddress,
      'logo': logo,
    };
  }

  factory OrganizationModel.fromEntity(OrganizationEntity entity) {
    return OrganizationModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      email: entity.email,
      registrationNumber: entity.registrationNumber,
      description: entity.description,
      postalAddress: entity.postalAddress,
      normalAddress: entity.normalAddress,
      logo: entity.logo,
    );
  }
}
