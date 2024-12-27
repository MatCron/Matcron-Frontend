import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/type/domain/usecases/get_types.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_event.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_state.dart';
import 'package:matcron/core/resources/data_state.dart';

class RemoteTypeBloc extends Bloc<RemoteTypeEvent, RemoteTypeState> {
  final GetTypesUseCase _getTypesTilesUseCase;

  RemoteTypeBloc(this._getTypesTilesUseCase) : super(RemoteTypesLoading()) {
    on<GetTypesTiles>(onGetTypes);
  }

  void onGetTypes(GetTypesTiles event, Emitter<RemoteTypeState> emit) async {
    final dataState = await _getTypesTilesUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteTypesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteTypesException(dataState.error!));
    }
  }

}