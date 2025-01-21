import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

class MattressEntity {
  String? uid;
  String? mattressTypeId;
  String? batchNo;
  DateTime? productionDate;
  String? location;
  String? orgId;
  String? epcCode;
  int? status;
  DateTime? lifeCyclesEnd;
  int? daysToRotate;
  String? type;
  MattressTypeEntity? mattressType;

  MattressEntity({
    this.uid,
    this.mattressTypeId,
    this.batchNo,
    this.productionDate,
    this.orgId,
    this.epcCode,
    this.status,
    this.lifeCyclesEnd,
    this.daysToRotate,
    this.location,
    this.type,
    this.mattressType,
  });

  MattressEntity copyWith({
    String? mattressTypeId,
    String? batchNo,
    DateTime? productionDate,
    String? orgId,
    String? epcCode,
    int? status,
    DateTime? lifeCyclesEnd,
    int? daysToRotate,
    String? location,
    String? type,
    MattressTypeEntity? mattressType
  }) {
    return MattressEntity(
      uid: uid,
      mattressTypeId: mattressTypeId ?? this.mattressTypeId,
      batchNo: batchNo ?? this.batchNo,
      productionDate: productionDate ?? this.productionDate,
      orgId: orgId ?? this.orgId,
      epcCode: epcCode ?? this.epcCode,
      status: status ?? this.status,
      lifeCyclesEnd: lifeCyclesEnd ?? this.lifeCyclesEnd,
      daysToRotate: daysToRotate ?? this.daysToRotate,
      location: location ?? this.location,
      type: type ?? this.type,
      mattressType: mattressType ?? this.mattressType,
    );
  }
}