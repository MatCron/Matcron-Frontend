class GroupEntity {
  String? uid;
  String? name;
  String? description;
  DateTime? createdDate;
  int? status;
  int? mattressCount;
  String? receiverOrganisationName;
  String? senderOrganisationName;
  int? transferOutPurpose;
  bool? isImported;

  GroupEntity({
    this.uid,
    this.name,
    this.description,
    this.mattressCount,
    this.receiverOrganisationName,
    this.senderOrganisationName,
    this.status,
    this.transferOutPurpose,
    this.isImported
  });
}