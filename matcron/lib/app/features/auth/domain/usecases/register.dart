import 'package:matcron/app/features/auth/data/models/user_db.dart';
import 'package:matcron/app/features/auth/domain/entities/user.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetRegisterUseCase implements Usecase<DataState<UserEntity>, UserRegistrationDbModel> {

  final AuthRepository _authRepository;

  GetRegisterUseCase(this._authRepository);
  @override
  Future<DataState<UserEntity>> call({UserRegistrationDbModel? params}) {
    return _authRepository.register(params!);
  }

}