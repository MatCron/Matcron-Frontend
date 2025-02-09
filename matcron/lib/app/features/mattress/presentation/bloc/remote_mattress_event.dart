import 'package:equatable/equatable.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';

abstract class RemoteMattressEvent extends Equatable {
  final List<MattressEntity> ? mattresses;
  final MattressEntity ? mattress;

  const RemoteMattressEvent({this.mattresses, this.mattress});

  @override
  List<Object> get props => [];
}

class GetAllMattresses extends RemoteMattressEvent {
  const GetAllMattresses();
}

class GenerateRfid extends RemoteMattressEvent {
  const GenerateRfid(MattressEntity mattress) : super(mattress: mattress);
}

class UpdateMattress extends RemoteMattressEvent {
  const UpdateMattress(MattressEntity mattress) : super(mattress: mattress);
}