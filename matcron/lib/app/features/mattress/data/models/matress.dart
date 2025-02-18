import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/type/data/models/type_model.dart';

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
    super.location,
    super.type,
    super.mattressType,
  });

  factory MattressModel.fromJson(Map<String, dynamic> map) {
    return MattressModel(
      uid: map['id'] ?? "",
      mattressTypeId: map['mattressTypeId'] ?? "",
      batchNo: map['batchNo'] ?? "",
      productionDate: map['productionDate'] != null
          ? DateTime.parse(map['productionDate'])
          : null,
      orgId: map['orgId'] ?? "",
      epcCode: map['epcCode'] ?? "",
      status: map['status'] ?? 0,
      lifeCyclesEnd: map['lifeCyclesEnd'] != null
          ? DateTime.parse(map['lifeCyclesEnd'])
          : null,
      daysToRotate: map['daysToRotate'] ?? 0,
      location: map['location'] ?? "",
      type: map['type'] ?? "",
      mattressType: map['mattressType'] != null ? TypeModel.fromJson(map['mattressType']) : TypeModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'mattressTypeId': mattressTypeId,
      'batchNo': batchNo,
      'productionDate': productionDate != null
          ? "${productionDate!.year.toString().padLeft(4, '0')}-${productionDate!.month.toString().padLeft(2, '0')}-${productionDate!.day.toString().padLeft(2, '0')}"
          : null,
      'orgId': orgId,
      'epcCode': epcCode,
      'status': status,
      'lifeCyclesEnd': lifeCyclesEnd != null
          ? "${lifeCyclesEnd!.year.toString().padLeft(4, '0')}-${lifeCyclesEnd!.month.toString().padLeft(2, '0')}-${lifeCyclesEnd!.day.toString().padLeft(2, '0')}"
          : null,
      'daysToRotate': daysToRotate,
      'location': location,
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
      location: entity.location,
    );
  }
}
