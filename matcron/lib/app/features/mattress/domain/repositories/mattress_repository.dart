import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class MattressRepository {
  Future<DataState<List<MattressEntity>>> getMattresses();
  Future<DataState<String>> generateRfid(MattressEntity entity);
  Future<DataState<MattressEntity>> getMattressById(String id);
}