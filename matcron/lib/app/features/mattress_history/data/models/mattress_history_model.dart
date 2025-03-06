import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';

class MattressHistoryModel extends MattressHistoryEntity {
  MattressHistoryModel(
      {super.id,
      super.mattressId,
      super.details,
      super.status,
      super.timeStamp,
      super.type});

  factory MattressHistoryModel.fromJson(Map<String, dynamic> map) {
    return MattressHistoryModel(
      id: map['id'] ?? "",
      mattressId: map['mattressId'] ?? "",
      details: map['details'] != null && map['details'] is String
          ? jsonDecode(map['details'])['Detail']
          : "",
      status: map['status'] as int,
      type: map['type'] as int,
      timeStamp: map['timeStamp'] != null
          ? DateFormat("MM/dd/yyyy HH:mm:ss").parse(map['timeStamp'])
          : null,
    );
  }
}
