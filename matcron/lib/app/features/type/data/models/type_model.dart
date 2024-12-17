import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

class TypeModel extends MattressTypeEntity {
  TypeModel({
    super.id,
    super.name,
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
      width: map['width'] ?? 0.0,
      height: map['height'] ?? 0.0,
      composition: map['composition'] ?? "",
      rotationInterval: map['rotationInterval'] ?? 0,
      recyclingDetails: map['recyclingDetails'] ?? "",
      expectedLifespan: map['expectedLifespan'] ?? 0,
      warrantyPeriod: map['warrantyPeriod'] ?? 0,
      stock: map['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
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
