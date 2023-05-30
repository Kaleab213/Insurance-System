import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class NotificationLoad extends NotificationEvent {
  const NotificationLoad();

  @override
  List<Object> get props => [];
}

class NotificationCreate extends NotificationEvent {
  final Notification notification;

  const NotificationCreate(this.notification);

  @override
  List<Object> get props => [notification];

  @override
  String toString() =>
      'Notification Created {notification Id: ${notification.notificationId}}';
}
