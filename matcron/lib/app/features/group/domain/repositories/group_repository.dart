import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class GroupRepository {
  Future<DataState<GroupEntity>> getImportPreviewFromMattressId(String uid);
  Future<DataState<void>> importMattressFromGroup(String uid);
}