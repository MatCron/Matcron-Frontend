import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/core/resources/database_service.dart';

class CacheService {
  // Retrieve from cache
  Future<List<MattressEntity>> getMattressesFromCache() async {
    return await DatabaseService.instance.getMattresses();
  }

  Future<List<MattressTypeEntity>> getTypesFromCache() async {
    return await DatabaseService.instance.getTypes();
  }

  Future<List<GroupEntity>> getGroupsFromCache() async {
    return await DatabaseService.instance.getGroups();
  }

  Future<List<OrganizationEntity>> getOrganizationsFromCache() async {
    return await DatabaseService.instance.getOrganizations();
  }

  // Write to cache
  Future<void> writeMattressesToCache(List<MattressEntity> mattresses) async {
    await DatabaseService.instance.clearAndInsertMattresses(mattresses);
  }

  Future<void> writeTypesToCache(List<MattressTypeEntity> types) async {
    await DatabaseService.instance.clearAndInsertTypes(types);
  }

  Future<void> writeGroupsToCache(List<GroupEntity> groups) async {
    await DatabaseService.instance.clearAndInsertGroups(groups);
  }

  Future<void> writeOrganizationsToCache(List<OrganizationEntity> organizations) async {
    await DatabaseService.instance.clearAndInsertOrganizations(organizations);
  }
}
