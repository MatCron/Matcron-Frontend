import 'package:matcron/app/features/dashboard/domain/entities/dashboard.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    int ? activeMattresses,
    int ? transferredOutMattresses,
    int ? reviewRequired,
    int ? lifecycleEnd,
  }) : super(
    activeMattresses: activeMattresses ?? 0,
    transferredOutMattresses: transferredOutMattresses ?? 0,
    reviewRequired: reviewRequired ?? 0,
    lifecycleEnd: lifecycleEnd ?? 0,
  );

  factory DashboardModel.fromJson(Map<String, dynamic> map) {
    return DashboardModel(
      activeMattresses: map['activeMattresses'] ?? 0,
      transferredOutMattresses: map['transferredOutMattresses'] ?? 0,
      reviewRequired: map['reviewRequired'] ?? 0,
      lifecycleEnd: map['lifecycleEnd'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeMattresses':activeMattresses,
      'transferredOutMattresses':transferredOutMattresses,
      'reviewRequired':reviewRequired,
      'lifecycleEnd':lifecycleEnd,
    };
  }
}