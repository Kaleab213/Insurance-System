import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/repository.dart';
import '../blocs.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(NotificationLoading()) {
    on<NotificationLoad>((event, emit) async {
      emit(NotificationLoading());
      try {
        final notifications = await notificationRepository.fetchAll();
        emit(NotificationOperationSuccess(notifications));
      } catch (error) {
        emit(NotificationOperationFailure(error));
      }
    });

    on<NotificationCreate>((event, emit) async {
      try {
        await notificationRepository.create(event.notification);
        final notifications = await notificationRepository.fetchAll();
        emit(NotificationOperationSuccess(notifications));
      } catch (error) {
        emit(NotificationOperationFailure(error));
      }
    });
  }
}
