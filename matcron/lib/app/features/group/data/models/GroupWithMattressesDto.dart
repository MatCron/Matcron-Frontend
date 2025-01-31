class GroupWithMattressesDto {
  final String id;
  final String name;
  final String? description;
  final String? senderOrganisationName;
  final String? receiverOrganisationName;
  final int mattressCount;
  final DateTime createdDate;
  final DateTime? modifiedDate;
  final List<MattressDto> mattressList;

  GroupWithMattressesDto({
    required this.id,
    required this.name,
    this.description,
    this.senderOrganisationName,
    this.receiverOrganisationName,
    required this.mattressCount,
    required this.createdDate,
    this.modifiedDate,
    required this.mattressList,
  });

  factory GroupWithMattressesDto.fromJson(Map<String, dynamic> json) {
    return GroupWithMattressesDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      senderOrganisationName: json['senderOrganisationName'],
      receiverOrganisationName: json['receiverOrganisationName'],
      mattressCount: json['mattressCount'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: json['modifiedDate'] != null ? DateTime.parse(json['modifiedDate']) : null,
      mattressList: List<MattressDto>.from(json['mattressList'].map((x) => MattressDto.fromJson(x))),
    );
  }
}

class MattressDto {
  final String? uid;
  final String? mattressTypeId;
  final String? batchNo;
  final String? mattressTypeName;
  final DateTime? productionDate;
  final String? orgId;
  final String? epcCode;
  final String? location;
  final int? status;
  final DateTime? lifeCyclesEnd;
  final int? daysToRotate;

  MattressDto({
    this.uid,
    this.mattressTypeId,
    this.batchNo,
    this.mattressTypeName,
    this.productionDate,
    this.orgId,
    this.epcCode,
    this.location,
    this.status,
    this.lifeCyclesEnd,
    this.daysToRotate,
  });

  factory MattressDto.fromJson(Map<String, dynamic> json) {
    return MattressDto(
      uid: json['uid'],
      mattressTypeId: json['mattressTypeId'],
      batchNo: json['batchNo'],
      mattressTypeName: json['mattressTypeName'],
      productionDate: json['productionDate'] != null ? DateTime.parse(json['productionDate']) : null,
      orgId: json['orgId'],
      epcCode: json['epcCode'],
      location: json['location'],
      status: json['status'],
      lifeCyclesEnd: json['lifeCyclesEnd'] != null ? DateTime.parse(json['lifeCyclesEnd']) : null,
      daysToRotate: json['daysToRotate'],
    );
  }
}