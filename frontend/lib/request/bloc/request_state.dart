import 'package:equatable/equatable.dart';
import 'package:pro/request/model/request_model.dart';

// import '../model/Herd_model.dart';


abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestLoading extends RequestState {}

class RequestDataLoaded extends RequestState {
  final List<Request> requests;
  final String userRole = "COSTOMER";
  const RequestDataLoaded([this.requests = const []]);

  @override
  List<Object> get props => [requests];
}
class RequestLoadingforAdmin extends RequestState {}

class RequestDataLoadedforAdmin extends RequestState {
  final List<Request> requests;
  final String userRole = "ADMIN";
  const RequestDataLoadedforAdmin([this.requests = const []]);

  @override
  List<Object> get props => [requests];
}

class RequestDataLoadingError extends RequestState {
  final Object error;

  const RequestDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
