import 'package:equatable/equatable.dart';
import 'package:pro/Notification/model/notification_model.dart';

import '../model/notification_model.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class NotificationLoad extends NotificationEvent {
  const NotificationLoad();

  @override
  List<Object> get props => [];
}

class NotificationCreate extends NotificationEvent {
  final Notifications notification;

  const NotificationCreate(this.notification);

  @override
  List<Object> get props => [notification];

  @override
  String toString() => 'Notification Created {Herd Id: $notification.id}';
}

class NotificationUpdate extends NotificationEvent {
  final String id;
  final Notifications notification;

  const NotificationUpdate(this.id, this.notification);

  @override
  List<Object> get props => [id, notification];

  @override
  String toString() => 'Notification Updated {Herd Id: $notification.id}';
}

class NotificationDelete extends NotificationEvent {
  final String id;

  const NotificationDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Notification Deleted {Notification Id: $id}';

  @override
  bool? get stringify => true;
}
