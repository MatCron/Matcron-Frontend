import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetTypeUsecase implements Usecase<DataState<MattressTypeEntity>, String> {
  final TypeRepository _typeRepository;

  GetTypeUsecase(this._typeRepository);

  @override
  Future<DataState<MattressTypeEntity>> call({String? params}) {
    return _typeRepository.getType(params!);
  }
}