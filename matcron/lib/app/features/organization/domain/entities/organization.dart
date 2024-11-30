class OrganizationEntity {
  String ? id;
  String ? name;
  String ? type;
  String ? email;
  int ? registrationNumber;
  String ? description;
  String ? address;
  String ? eirCode;
  String ? county;

  OrganizationEntity({
    this.id,
    this.name,
    this.type,
    this.email,
    this.registrationNumber,
    this.description,
    this.address,
    this.eirCode,
    this.county
  });
}