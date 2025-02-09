import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/group/domain/repositories/group_repository.dart';
import 'package:matcron/app/features/mattress/domain/usecases/generate_rfid_.dart';
import 'package:matcron/app/features/mattress/domain/usecases/get_all_mattresses.dart';
import 'package:matcron/app/features/mattress/domain/usecases/update_mattress.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_state.dart';
import 'package:matcron/app/features/type/domain/repositories/type_repository.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteMattressBloc
    extends Bloc<RemoteMattressEvent, RemoteMattressState> {
  final GetAllMattressesUsecase _getAllMattressesUsecase;
  final GenerateRfidUsecase _generateRfidUsecase;
  final UpdateMattressUseCase _updateMattressUseCase;
  final TypeRepository _typeRepository;
  final GroupRepository _groupRepository;

  RemoteMattressBloc(this._getAllMattressesUsecase, this._generateRfidUsecase, this._typeRepository, this._updateMattressUseCase, this._groupRepository)
      : super(const RemoteMattressInitial()) {
    on<GetAllMattresses>(onGetAllMattresses);
    on<GenerateRfid>(onGenerateRfid);
    on<UpdateMattress>(onUpdateMattress);
  }

  void onGetAllMattresses(
      GetAllMattresses event, Emitter<RemoteMattressState> emit) async {
        emit(RemoteMattressesLoading());
    final dataState = await _getAllMattressesUsecase();
    final typesDataState = await _typeRepository.getTypes();
    final groupDataState = await _groupRepository.getGroups(1);


    if (
      dataState is DataSuccess && dataState.data != null && 
      typesDataState is DataSuccess && typesDataState.data != null
      ) {
      emit(RemoteMattressesDone(dataState.data!, typesDataState.data!, "", groupDataState is DataSuccess ? groupDataState.data! : []));
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
      emit(RemoteMattressesDone([], [], dataState.data!, []));
    }

    if (dataState is DataFailed) {
      emit(RemoteMattressesException(dataState.error!));
    }
  }

  void onUpdateMattress(UpdateMattress event, Emitter<RemoteMattressState> emit) async {
    emit(RemoteMattressesLoading());

    final dataState = await _updateMattressUseCase(params: event.mattress);
    final mattresses = await _getAllMattressesUsecase();
    final typesDataState = await _typeRepository.getTypes();
    final groupDataState = await _groupRepository.getGroups(1);

    if (dataState is DataSuccess) {
      emit(RemoteMattressesDone(mattresses.data!, typesDataState.data!, "", groupDataState.data!));
    }
  }
}
