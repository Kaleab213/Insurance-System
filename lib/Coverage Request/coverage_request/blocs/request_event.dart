import 'package:equatable/equatable.dart';

import '../models/request.dart';

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
  String toString() => 'Request Created {request Id: ${request.coverage_id}}';
}

class RequestUpdate extends RequestEvent {
  final int coverage_id;
  final Request request;

  const RequestUpdate(this.coverage_id, this.request);

  @override
  List<Object> get props => [coverage_id, request];

  @override
  String toString() => 'Request Updated {request Id: ${request.coverage_id}}';
}

class RequestDelete extends RequestEvent {
  final int coverage_id;

  const RequestDelete(this.coverage_id);

  @override
  List<Object> get props => [coverage_id];

  @override
  toString() => 'Request Deleted {request Id: $coverage_id}';

  @override
  bool? get stringify => true;
}
