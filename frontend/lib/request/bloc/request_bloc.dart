import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/request/model/request_model.dart';
import 'package:pro/request/repository/request_repository.dart';
// import '../repository/Herd_repository.dart';
import 'request_event.dart';
import 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepository requestRepository;

  RequestBloc({required this.requestRepository}) : super(RequestLoading()) {
    
    on<RequestLoad>((event, emit) async {
      emit(RequestLoading());
      try {
        final List<Request> requests = await requestRepository.fetchAll();

        emit(
          RequestDataLoaded(requests),
        );
      } catch (error) {
        print(error);
        emit(RequestDataLoadingError(error));
      }
    });

    on<RequestCreate>((event, emit) async {
      try {
        print(event.request);
        await requestRepository.create(event.request);
        final requests = await requestRepository.fetchAll();
        emit(RequestDataLoaded(requests));
      } catch (error) {
        print(error);
        emit(RequestDataLoadingError(error));
      }
    });

    on<RequestUpdate>((event, emit) async {
      try {
        await requestRepository.update(event.id, event.request);
        final requests = await requestRepository.fetchAll();
        emit(RequestDataLoaded(requests));
      } catch (error) {
        print(error);
        emit(RequestDataLoadingError(error));
      }
    });
    
    on<RequestApprove>((event, emit) async {
      try {
        await requestRepository.appove(event.id, event.status);
        final requests = await requestRepository.fetchAll();
        emit(RequestDataLoaded(requests));
      } catch (error) {
        print(error);
        emit(RequestDataLoadingError(error));
      }
    });
    
    on<RequestDelete>((event, emit) async {
      try {
        await requestRepository.delete(event.id);
        final requests = await requestRepository.fetchAll();
        emit(RequestDataLoaded(requests));
      } catch (error) {
        emit(RequestDataLoadingError(error));
      }
    });
    on<RequestLoadforAdmin>((event, emit) async {
      emit(RequestLoadingforAdmin());
      try {
        final List<Request> requests = await requestRepository.fetchAllforAdmin();

        emit(
          RequestDataLoadedforAdmin(requests),
        );
      } catch (error) {
        print(error);
        emit(RequestDataLoadingError(error));
      }
    });
  }
}
