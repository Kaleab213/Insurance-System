import 'package:equatable/equatable.dart';
import 'package:pro/request/model/request_model.dart';

// import '../model/Herd_model.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();
}

class RequestLoad extends RequestEvent {
  const RequestLoad();

  @override
  List<Object> get props => [];
}
class RequestLoadforAdmin extends RequestEvent {
  const RequestLoadforAdmin();

  @override
  List<Object> get props => [];
}

class RequestCreate extends RequestEvent {
  final Request request;

  const RequestCreate(this.request);

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'Request Created {Request Id: ${request.id}}';
}

class RequestUpdate extends RequestEvent {
  final int id;
  final Request request;

  const RequestUpdate({required this.id, required this.request});

  @override
  List<Object> get props => [id, request];

  @override
  String toString() => 'Request Updated {Request Id: ${request.id}}';
}
class RequestApprove extends RequestEvent {
  final int id;
  final bool status;

  const RequestApprove({required this.id, required this.status});

  @override
  List<Object> get props => [id, status];

  @override
  String toString() => 'Request Updated {Request Id: ${id}}';
}

class RequestDelete extends RequestEvent {
  final int id;

  const RequestDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Request Deleted {Request Id: $id}';

  @override
  bool? get stringify => true;
}
