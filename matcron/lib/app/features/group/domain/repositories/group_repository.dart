import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/app/features/group/data/models/GroupWithMattressesDto.dart';

abstract class GroupRepository {
  Future<DataState<GroupEntity>> getImportPreviewFromMattressId(String uid);
  Future<DataState<void>> importMattressFromGroup(String uid);

  //Bloc Methods
  Future<DataState<List<GroupEntity>>> getGroups(int status);
  Future<DataState<GroupEntity>> createGroup(CreateGroupModel model);
  Future<DataState<GroupWithMattressesDto>> getGroupById(String id);
  Future<DataState<void>> transferOut(String uid);
}