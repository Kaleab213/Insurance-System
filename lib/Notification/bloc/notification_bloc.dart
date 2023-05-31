import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/Notification/model/notification_model.dart';
import 'package:pro/Notification/repository/notification_repository.dart';
import '../repository/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository}) : super(NotificationLoading()) {
    on<NotificationLoad>(
      (event, emit) async {
        emit(NotificationLoading());
        try {
          final notifications = await notificationRepository.fetchAll();
          emit(NotificationDataLoaded(notifications as Iterable<Notifications>));
        } catch (error) {
          emit(NotificationDataLoadingError(error));
        }
      },
    );

    on<NotificationCreate>(
      (event, emit) async {
        try {
          await notificationRepository.create(event.notification);
          final notifications = await notificationRepository.fetchAll();
          emit(NotificationDataLoaded(notifications as Iterable<Notifications>));
        } catch (error) {
          emit(NotificationDataLoadingError(error));
        }
      },
    );

    on<NotificationUpdate>(
      (event, emit) async {
        try {
          await notificationRepository.update(event.id, event.notification);
          final notifications = await notificationRepository.fetchAll();
          emit(NotificationDataLoaded(notifications as Iterable<Notifications>));
        } catch (error) {
          emit(NotificationDataLoadingError(error));
        }
      },
    );

    on<NotificationDelete>(
      (event, emit) async {
        try {
          await notificationRepository.delete(event.id);
          final notifications = await notificationRepository.fetchAll();
          emit(NotificationDataLoaded(notifications as Iterable<Notifications>));
        } catch (error) {
          emit(NotificationDataLoadingError(error));
        }
      },
    );
  }
}
