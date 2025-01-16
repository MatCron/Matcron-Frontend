import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class UpdateMattressUseCase implements Usecase<DataState<void>, MattressEntity> {
  final MattressRepository _mattressRepository;

  UpdateMattressUseCase(this._mattressRepository);

  @override
  Future<DataState<void>> call({MattressEntity? params}) {
    return _mattressRepository.updateMattress(params!.uid!, params);
  }
}