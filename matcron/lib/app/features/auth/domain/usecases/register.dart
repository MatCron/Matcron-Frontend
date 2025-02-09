import 'package:matcron/app/features/auth/domain/entities/registration_response.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetRegisterUseCase implements Usecase<DataState<RegistrationResponseEntity>, UserRegistrationEntity> {

  final AuthRepository _authRepository;

  GetRegisterUseCase(this._authRepository);
  @override
  Future<DataState<RegistrationResponseEntity>> call({UserRegistrationEntity? params}) {
    return _authRepository.register(params!);
  }

}