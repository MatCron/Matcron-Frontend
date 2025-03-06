import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';

class MattressHistoryModel extends MattressHistoryEntity {
  MattressHistoryModel({
    super.id,
    super.mattressId,
    super.details,
    super.status,
    super.timeStamp,
    super.type
  });

  factory MattressHistoryModel.fromJson(Map<String, dynamic> map) {
    return MattressHistoryModel(
      id: map['id'] ?? "",
      mattressId: map['mattressId'] ?? "",
      details: map['details'] ?? "",
      status: map['status'] as int,
      type: map['type'] as int,
      timeStamp: map['timeStamp'] != null ? DateTime.parse(map['timeStamp']) : null
    );
  }

}