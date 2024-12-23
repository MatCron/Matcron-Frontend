import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';

class MattressModel extends MattressEntity {
  MattressModel({
    super.uid,
    super.mattressTypeId,
    super.batchNo,
    super.productionDate,
    super.orgId,
    super.epcCode,
    super.status,
    super.lifeCyclesEnd,
    super.daysToRotate,
  });

  factory MattressModel.fromJson(Map<String, dynamic> map) {
    return MattressModel(
      uid: map['uid'] ?? "",
      mattressTypeId: map['mattressTypeId'] ?? "",
      batchNo: map['batchNo'] ?? "",
      productionDate: map['productionDate'] ?? "",
      orgId: map['orgId'] ?? "",
      epcCode: map['epcCode'] ?? "",
      status: map['status'] ?? "",
      lifeCyclesEnd: map['lifeCyclesEnd'] ?? "",
      daysToRotate: map['daysToRotate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'mattressTypeId': mattressTypeId,
      'batchNo': batchNo,
      'productionDate': productionDate,
      'orgId': orgId,
      'epcCode': epcCode,
      'status': status,
      'lifeCyclesEnd': lifeCyclesEnd,
      'daysToRotate': daysToRotate,
    };
  }

  factory MattressModel.fromEntity(MattressEntity entity) {
    return MattressModel(
      uid: entity.uid,
      mattressTypeId: entity.mattressTypeId,
      batchNo: entity.batchNo,
      productionDate: entity.productionDate,
      orgId: entity.orgId,
      epcCode: entity.epcCode,
      status: entity.status,
      lifeCyclesEnd: entity.lifeCyclesEnd,
      daysToRotate: entity.daysToRotate,
    );
  }
}