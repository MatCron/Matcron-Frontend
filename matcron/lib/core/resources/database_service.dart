import 'package:matcron/app/features/group/data/models/group.dart';
import 'package:matcron/app/features/group/domain/entities/group_entity.dart';
import 'package:matcron/app/features/mattress/data/models/matress.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/organization/data/models/organization.dart';
import 'package:matcron/app/features/organization/domain/entities/organization.dart';
import 'package:matcron/app/features/type/data/models/type_model.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _database;

  DatabaseService._constructor();
  
  final String _mattressTableName = "mattresses";
  final String _typeTableName = "types";
  final String _groupTableName = "groups";
  final String _organizationsTableName = "organizations";

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_mattressTableName (
            uid TEXT PRIMARY KEY,
            mattressTypeId TEXT,
            batchNo TEXT,
            productionDate TEXT,
            location TEXT,
            orgId TEXT,
            epcCode TEXT,
            status INTEGER,
            lifeCyclesEnd TEXT,
            daysToRotate INTEGER,
            type TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE $_typeTableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            width REAL,
            length REAL,
            height REAL,
            composition TEXT,
            rotationInterval REAL,
            recyclingDetails TEXT,
            expectedLifespan REAL,
            warrantyPeriod REAL,
            stock INTEGER
          )
        ''');

        db.execute('''
          CREATE TABLE $_groupTableName (
            uid TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            createdDate TEXT,
            status INTEGER,
            mattressCount INTEGER,
            receiverOrganisationName TEXT,
            senderOrganisationName TEXT,
            transferOutPurpose INTEGER,
            isImported INTEGER
          )
        ''');

        db.execute('''
          CREATE TABLE $_organizationsTableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            type TEXT,
            email TEXT,
            registrationNumber TEXT,
            description TEXT,
            postalAddress TEXT,
            normalAddress TEXT,
            logo TEXT,
            eirCode TEXT,
            county TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  // Clear and Insert for Mattresses
  Future<void> clearAndInsertMattresses(List<MattressEntity> mattresses) async {
    final db = await getDatabase();
    Batch batch = db.batch();
    batch.delete(_mattressTableName);
    for (var mattress in mattresses) {
      var t = MattressModel.fromEntity(mattress);
      batch.insert(_mattressTableName, t.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // Clear and Insert for Types
  Future<void> clearAndInsertTypes(List<MattressTypeEntity> types) async {
    final db = await getDatabase();
    Batch batch = db.batch();
    batch.delete(_typeTableName);
    for (var type in types) {
      var t = TypeModel.fromEntity(type);
      batch.insert(_typeTableName, t.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // Clear and Insert for Groups
  Future<void> clearAndInsertGroups(List<GroupEntity> groups) async {
    final db = await getDatabase();
    Batch batch = db.batch();
    batch.delete(_groupTableName);
    for (var group in groups) {
      var t = GroupModel.fromEntity(group);
      batch.insert(_groupTableName, t.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // Clear and Insert for Organizations
  Future<void> clearAndInsertOrganizations(List<OrganizationEntity> organizations) async {
    final db = await getDatabase();
    Batch batch = db.batch();
    batch.delete(_organizationsTableName);
    for (var org in organizations) {
      var t = OrganizationModel.fromEntity(org);
      batch.insert(_organizationsTableName, t.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // Retrieve Mattresses
  Future<List<MattressEntity>> getMattresses() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_mattressTableName);
    return maps.map((json) => MattressModel.fromJson(json)).toList();
  }

  // Retrieve Types
  Future<List<MattressTypeEntity>> getTypes() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_typeTableName);
    return maps.map((json) => TypeModel.fromJson(json)).toList();
  }

  // Retrieve Groups
  Future<List<GroupEntity>> getGroups() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_groupTableName);
    return maps.map((json) => GroupModel.fromJson(json)).toList();
  }

  // Retrieve Organizations
  Future<List<OrganizationEntity>> getOrganizations() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_organizationsTableName);
    return maps.map((json) => OrganizationModel.fromJson(json)).toList();
  }
}
