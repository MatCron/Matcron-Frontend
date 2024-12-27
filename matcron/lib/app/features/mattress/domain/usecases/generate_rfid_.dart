import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/mattress/domain/repositories/mattress_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GenerateRfidUsecase implements Usecase<DataState<String>, MattressEntity> {
  final MattressRepository _mattressRepository;

  GenerateRfidUsecase(this._mattressRepository);

  @override
  Future<DataState<String>> call({MattressEntity? params}) {
    return _mattressRepository.generateRfid(params!);
  }
}