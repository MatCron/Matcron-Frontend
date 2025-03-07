class MattressHistoryEntity {
  String? id;
  String? mattressId;
  int? status;
  String? details;
  String? oldDetails;
  String? newDetails;
  int? type;
  DateTime? timeStamp;

  MattressHistoryEntity({
    this.id,
    this.mattressId,
    this.status,
    this.details,
    this.type,
    this.timeStamp,
    this.oldDetails,
    this.newDetails
  });
}