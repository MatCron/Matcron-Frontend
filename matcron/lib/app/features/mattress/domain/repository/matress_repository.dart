import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/core/resources/data_state.dart';

abstract class MatressRepository {
  Future<DataState<List<MattressEntity>>> getMattresses();
  Future<DataState<void>> updateMattress();
  Future<DataState<String>> addMattress();
}