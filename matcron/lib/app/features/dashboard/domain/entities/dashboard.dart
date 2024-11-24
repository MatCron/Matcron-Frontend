class DashboardEntity {
  int activeMattresses = 0;
  int transferredOutMattresses = 0;
  int reviewRequired = 0;
  int lifecycleEnd = 0;

  DashboardEntity({
    required this.activeMattresses,
    required this.transferredOutMattresses,
    required this.reviewRequired,
    required this.lifecycleEnd,
  });
}
