import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetAllMattressesUsecase implements Usecase<DataState<List<MattressEntity>>, void> {
  final MattressRepository _mattressRepository;

  GetAllMattressesUsecase(this._mattressRepository);

  @override
  Future<DataState<List<MattressEntity>>> call({void params}) {
    return _mattressRepository.getMattresses();
  }
}