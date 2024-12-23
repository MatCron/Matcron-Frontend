class MattressEntity {
  String? uid;
  String? mattressTypeId;
  String? batchNo;
  DateTime? productionDate;
  String? orgId;
  String? epcCode;
  int? status;
  DateTime? lifeCyclesEnd;
  int? daysToRotate;

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
    );
  }
}