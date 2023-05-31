import 'package:equatable/equatable.dart';
import 'package:pro/Notification/model/notification_model.dart';

import '../model/notification_model.dart';


abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {}

class NotificationDataLoaded extends NotificationState {
  final Iterable<Notifications> notifications;

  const NotificationDataLoaded([this.notifications = const []]);

  @override
  List<Object> get props => [notifications];
}

class NotificationDataLoadingError extends NotificationState {
  final Object error;

  const NotificationDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
