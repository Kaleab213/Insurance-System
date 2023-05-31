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

class RequestCreate extends RequestEvent {
  final Request request;

  const RequestCreate(this.request);

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'Request Created {Request Id: $request.id}';
}

class RequestUpdate extends RequestEvent {
  final String id;
  final Request request;

  const RequestUpdate({required this.id, required this.request});

  @override
  List<Object> get props => [id, request];

  @override
  String toString() => 'Request Updated {Request Id: $request.id}';
}

class RequestDelete extends RequestEvent {
  final String id;

  const RequestDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Request Deleted {Request Id: $id}';

  @override
  bool? get stringify => true;
}
