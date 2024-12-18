import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class DeleteTypeUseCase implements Usecase<DataState<void>, MattressTypeEntity> {
  final TypeRepository _typeRepository;

  DeleteTypeUseCase(this._typeRepository);

  @override
  Future<DataState<void>> call({MattressTypeEntity? params}) {
    return _typeRepository.deleteType(params!);
  }
}
