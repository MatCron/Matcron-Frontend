import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetTypesUseCase implements Usecase<DataState<List<MattressTypeEntity>>, void> {
  final TypeRepository _typeRepository;

  GetTypesUseCase(this._typeRepository);

  @override
  Future<DataState<List<MattressTypeEntity>>> call({void params}) {
    return _typeRepository.getTypes();
  }
}
