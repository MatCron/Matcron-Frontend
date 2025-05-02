import 'package:matcron/app/features/mattress_history/domain/entities/mattress_history.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class MattressHistoryRepository {
  Future<DataState<List<MattressHistoryEntity>>> getMattressHistoryById(String id);
}