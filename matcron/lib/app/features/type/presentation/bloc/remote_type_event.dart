import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/type/domain/entities/mattress_type.dart';

abstract class RemoteTypeEvent extends Equatable {
  final String ? id;
  final MattressTypeEntity ? type;
  const RemoteTypeEvent({this.id, this.type});

  @override
  List<Object> get props => [];
}

class GetTypesTiles extends RemoteTypeEvent {
  const GetTypesTiles();
}

class GetSingleType extends RemoteTypeEvent {
  const GetSingleType(String id) : super(id: id);
}

class AddType extends RemoteTypeEvent {
  const AddType(MattressTypeEntity type) : super(type: type);
}