import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {}

class NotificationOperationSuccess extends NotificationState {
  final Iterable<Notification> notifications;

  const NotificationOperationSuccess([this.notifications = const []]);

  @override
  List<Object> get props => [notifications];
}

class NotificationOperationFailure extends NotificationState {
  final Object error;
  const NotificationOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
