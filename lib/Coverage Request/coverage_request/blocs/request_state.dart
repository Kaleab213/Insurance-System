import 'package:equatable/equatable.dart';

import '../models/request.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestLoading extends RequestState {}

class RequestOperationSuccess extends RequestState {
  final Iterable<Request> requests;

  const RequestOperationSuccess([this.requests = const []]);

  @override
  List<Object> get props => [requests];
}

class RequestOperationFailure extends RequestState {
  final Object error;

  const RequestOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
