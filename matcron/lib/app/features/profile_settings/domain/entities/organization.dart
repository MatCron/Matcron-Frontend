class OrganizationEntity {
  String ? id;
  String ? name;
  String ? type;
  String ? email;
  String ? registrationNumber;
  String ? description;
  String ? postalAddress;
  String ? normalAddress;
  String ? logo;

  OrganizationEntity({
    this.id,
    this.name,
    this.type,
    this.email,
    this.registrationNumber,
    this.description,
    this.postalAddress,
    this.normalAddress,
    this.logo,
  });

  OrganizationEntity copyWith({
    String? name,
    String? type,
    String? email,
    String? registrationNumber,
    String? postalAddress,
    String? normalAddress,
  }) {
    return OrganizationEntity(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      email: email ?? this.email,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      description: description,
      postalAddress: postalAddress ?? this.postalAddress,
      normalAddress: normalAddress ?? this.normalAddress,
      logo: logo,
    );
  }
}
