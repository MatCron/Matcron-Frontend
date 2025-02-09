import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

abstract class RemoteTypeState extends Equatable {
  final List<MattressTypeEntity>? types;
  final MattressTypeEntity? type;
  final DioException? exception;

  const RemoteTypeState({this.type, this.types, this.exception});

  @override
  List<Object> get props {
    final propsList = <Object>[];

    if (types != null) propsList.add(types!);
    if (exception != null) propsList.add(exception!);
    if (type != null) propsList.add(type!);

    return propsList;
  }
}

class RemoteTypesLoading extends RemoteTypeState {
  const RemoteTypesLoading();
}

class RemoteTypesDone extends RemoteTypeState {
  const RemoteTypesDone(List<MattressTypeEntity> types) : super(types: types);
}

class RemoteTypesException extends RemoteTypeState {
  const RemoteTypesException(DioException exception) : super(exception: exception);
}