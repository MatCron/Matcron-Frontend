import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/mattress/domain/usecases/generate_rfid_.dart';
import 'package:matcron/app/features/mattress/domain/usecases/get_all_mattresses.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteMattressBloc
    extends Bloc<RemoteMattressEvent, RemoteMattressState> {
  final GetAllMattressesUsecase _getAllMattressesUsecase;
  final GenerateRfidUsecase _generateRfidUsecase;
  final TypeRepository _typeRepository;

  RemoteMattressBloc(this._getAllMattressesUsecase, this._generateRfidUsecase, this._typeRepository)
      : super(const RemoteMattressInitial()) {
    on<GetAllMattresses>(onGetAllMattresses);
    on<GenerateRfid>(onGenerateRfid);
  }

  void onGetAllMattresses(
      GetAllMattresses event, Emitter<RemoteMattressState> emit) async {
        emit(RemoteMattressesLoading());
    final dataState = await _getAllMattressesUsecase();
    final typesDataState = await _typeRepository.getTypes();

    if (dataState is DataSuccess && dataState.data != null && typesDataState is DataSuccess && typesDataState.data != null) {
      emit(RemoteMattressesDone(dataState.data!, typesDataState.data!, ""));
    }

    if (dataState is DataFailed) {
      emit(RemoteMattressesException(dataState.error!));
    }
  }

  void onGenerateRfid(
      GenerateRfid event, Emitter<RemoteMattressState> emit) async {
    emit(RemoteMattressesLoading());

    final dataState = await _generateRfidUsecase(params: event.mattress);

    if (dataState is DataSuccess) {
      emit(RemoteMattressesDone([], [], dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteMattressesException(dataState.error!));
    }
  }
}
