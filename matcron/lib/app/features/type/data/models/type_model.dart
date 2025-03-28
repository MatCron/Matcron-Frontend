import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

class TypeModel extends MattressTypeEntity {
  TypeModel({
    super.id,
    super.name,
    super.length,
    super.width,
    super.height,
    super.composition,
    super.rotationInterval,
    super.recyclingDetails,
    super.expectedLifespan,
    super.warrantyPeriod,
    super.stock,
  });

  factory TypeModel.fromJson(Map<String, dynamic> map) {
    return TypeModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      length: (map['length'] is int ? (map['length'] as int).toDouble() : map['length']) ?? 0.0,
      width: (map['width'] is int ? (map['width'] as int).toDouble() : map['width']) ?? 0.0,
      height: (map['height'] is int ? (map['height'] as int).toDouble() : map['height']) ?? 0.0,
      composition: map['composition'] ?? "",
      rotationInterval: (map['rotationInterval'] is int ? (map['rotationInterval'] as int).toDouble() : map['rotationInterval']) ?? 0.0,
      recyclingDetails: map['recyclingDetails'] ?? "",
      expectedLifespan: (map['expectedLifespan'] is int ? (map['expectedLifespan'] as int).toDouble() : map['expectedLifespan']) ?? 0.0,
      warrantyPeriod: (map['warrantyPeriod'] is int ? (map['warrantyPeriod'] as int).toDouble() : map['warrantyPeriod']) ?? 0.0,
      stock: map['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'length': length,
      'width': width,
      'height': height,
      'composition': composition,
      'rotationInterval': rotationInterval,
      'recyclingDetails': recyclingDetails,
      'expectedLifespan': expectedLifespan,
      'warrantyPeriod': warrantyPeriod,
      'stock': stock,
    };
  }

  factory TypeModel.fromEntity(MattressTypeEntity entity) {
    return TypeModel(
      id: entity.id,
      name: entity.name,
      length: entity.length,
      width: entity.width,
      height: entity.height,
      composition: entity.composition,
      rotationInterval: entity.rotationInterval,
      recyclingDetails: entity.recyclingDetails,
      expectedLifespan: entity.expectedLifespan,
      warrantyPeriod: entity.warrantyPeriod,
      stock: entity.stock,
    );
  }
}
