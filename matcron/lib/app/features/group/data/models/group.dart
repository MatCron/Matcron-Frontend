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
    super.isImported
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
      transferOutPurpose: map['transferOutPurpose'] ?? 0,
      isImported: map['isImported'] ?? false
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





class CreateGroupModel {
  final String name;
  final String description;
  final String receiverOrgId;
  final String senderOrgId;
  final int transferOutPurpose;

  CreateGroupModel({
    required this.name,
    required this.description,
    required this.receiverOrgId,
    required this.senderOrgId,
    required this.transferOutPurpose,
  });

  factory CreateGroupModel.fromJson(Map<String, dynamic> map) {
    return CreateGroupModel(
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      receiverOrgId: map['receiverOrgId'] ?? "",
      senderOrgId: map['senderOrgId'] ?? "",
      transferOutPurpose: map['transferOutPurpose'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'receiverOrgId': receiverOrgId,
      'senderOrgId': senderOrgId,
      'transferOutPurpose': transferOutPurpose,
    };
  }
}
