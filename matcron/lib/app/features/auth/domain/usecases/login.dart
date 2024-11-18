import 'package:matcron/app/features/auth/data/models/user_db.dart';
import 'package:matcron/app/features/auth/domain/entities/user.dart';
import 'package:matcron/app/features/auth/domain/repository/auth_repository.dart';
import 'package:matcron/core/resources/data_state.dart';
import 'package:matcron/core/usecases/usecase.dart';

class GetLoginUseCase implements Usecase<DataState<UserEntity>, UserLoginDbModel> {

  final AuthRepository _authRepository;

  GetLoginUseCase(this._authRepository);
  @override
  Future<DataState<UserEntity>> call({UserLoginDbModel? params}) {
    return _authRepository.login(params!);
  }

}