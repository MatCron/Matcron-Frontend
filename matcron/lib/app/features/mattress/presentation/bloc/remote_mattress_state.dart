import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

abstract class RemoteMattressState extends Equatable {
  final List<MattressEntity>? mattresses;
  final List<MattressTypeEntity>? types;
  final MattressEntity? mattress;
  final String? uid;
  final DioException? exception;

  const RemoteMattressState({this.mattress, this.mattresses, this.types, this.uid, this.exception});

  @override
  List<Object> get props {
    final propsList = <Object>[];

    if (mattresses != null) propsList.add(mattresses!);
    if (exception != null) propsList.add(exception!);
    if (mattress != null) propsList.add(mattress!);

    return propsList;
  }
}

class RemoteMattressesLoading extends RemoteMattressState {
  const RemoteMattressesLoading();
}

class RemoteMattressInitial extends RemoteMattressState {
  const RemoteMattressInitial();
}

class RemoteMattressesDone extends RemoteMattressState {
  const RemoteMattressesDone(List<MattressEntity> mattresses, List<MattressTypeEntity> types, String? uid) : super(mattresses: mattresses, types: types, uid: uid);
}

class RemoteMattressesException extends RemoteMattressState {
  const RemoteMattressesException(DioException exception) : super(exception: exception);
}


