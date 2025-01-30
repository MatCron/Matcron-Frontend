import 'package:matcron/app/features/group/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    super.uid,
    super.name,
    super.description,
    super.mattressCount,
    super.receiverOrganisationName,
    super.senderOrganisationName,
    super.status,
    super.transferOutPurpose,
  });

  factory GroupModel.fromJson(Map<String, dynamic> map) {
    return GroupModel(
      uid: map['id'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      mattressCount: map['mattressCount'] ?? 0,
      receiverOrganisationName: map['receiverOrganisationName'] ?? "",
      senderOrganisationName: map['senderOrganisationName'] ?? "",
      status: map['status'] ?? 0, // Assuming status is an integer, change if necessary
      transferOutPurpose: map['transferOutPurpose'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'description': description,
      'mattressCount': mattressCount,
      'receiverOrganisationName': receiverOrganisationName,
      'senderOrganisationName': senderOrganisationName,
      'status': status,
      'transferOutPurpose': transferOutPurpose,
    };
  }

  factory GroupModel.fromEntity(GroupEntity entity) {
    return GroupModel(
      uid: entity.uid,
      name: entity.name,
      description: entity.description,
      mattressCount: entity.mattressCount,
      receiverOrganisationName: entity.receiverOrganisationName,
      senderOrganisationName: entity.senderOrganisationName,
      status: entity.status,
      transferOutPurpose: entity.transferOutPurpose,
    );
  }
}
