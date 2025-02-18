import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class TypeRepository {
  Future<DataState<List<MattressTypeEntity>>> getTypes();
  Future<DataState<MattressTypeEntity>> getType(String id);
  Future<DataState<void>> addType(MattressTypeEntity type);
}