import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/request_repository.dart';
import 'blocs.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepository requestRepository;

  RequestBloc({required this.requestRepository}) : super(RequestLoading()) {
    on<RequestLoad>((event, emit) async {
      emit(RequestLoading());
      try {
        final requests = await requestRepository.fetchAll();
        emit(RequestOperationSuccess(requests));
      } catch (error) {
        emit(RequestOperationFailure(error));
      }
    });

    on<RequestCreate>((event, emit) async {
      try {
        await requestRepository.create(event.request);
        final requests = await requestRepository.fetchAll();
        emit(RequestOperationSuccess(requests));
      } catch (error) {
        emit(RequestOperationFailure(error));
      }
    });

    on<RequestUpdate>((event, emit) async {
      try {
        await requestRepository.update(event.coverage_id, event.request);
        final requests = await requestRepository.fetchAll();
        emit(RequestOperationSuccess(requests));
      } catch (error) {
        emit(RequestOperationFailure(error));
      }
    });

    on<RequestDelete>((event, emit) async {
      try {
        await requestRepository.delete(event.coverage_id);
        final requests = await requestRepository.fetchAll();
        emit(RequestOperationSuccess(requests));
      } catch (error) {
        emit(RequestOperationFailure(error));
      }
    });
  }
}
