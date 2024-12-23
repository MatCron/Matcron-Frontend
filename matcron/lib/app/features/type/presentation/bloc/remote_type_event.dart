import 'package:equatable/equatable.dart';

abstract class RemoteTypeEvent extends Equatable {
  final String ? id;
  const RemoteTypeEvent({this.id});

  @override
  List<Object> get props => [];
}

class GetTypesTiles extends RemoteTypeEvent {
  const GetTypesTiles();
}

class GetSingleType extends RemoteTypeEvent {
  const GetSingleType(String id) : super(id: id);
}