import 'package:matcron/app/features/auth/domain/entities/login_response.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetLoginUseCase implements Usecase<DataState<LoginResponseEntity>, UserLoginEntity> {

  final AuthRepository _authRepository;

  GetLoginUseCase(this._authRepository);
  @override
  Future<DataState<LoginResponseEntity>> call({UserLoginEntity? params}) {
    return _authRepository.login(params!);
  }

}