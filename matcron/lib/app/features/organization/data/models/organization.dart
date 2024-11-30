import 'package:matcron/app/features/organization/domain/entities/organization.dart';

class OrganizationModel extends OrganizationEntity {
  OrganizationModel({
    super.id,
    super.name,
    super.type,
    super.email,
    super.registrationNumber,
    super.description,
    super.address,
    super.eirCode,
    super.county,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      type: map['type'] ?? "",
      email: map['email'] ?? "",
      registrationNumber: map['registrationNumber'] ?? "",
      description: map['description'] ?? "",
      address: map['address'] ?? "",
      eirCode: map['eirCode'] ?? "",
      county: map['county'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'email': email,
      'registrationNumber': registrationNumber,
      'description': description,
      'address': address,
      'eirCode': eirCode,
      'county': county
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
        address: entity.address,
        eirCode: entity.eirCode,
        county: entity.county
      );
  }
}
