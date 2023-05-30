import '../data_providers/notification_data_provider.dart';
import '../models/notification.dart';

class NotificationRepository {
  final NotificationDataProvider dataProvider;
  NotificationRepository(this.dataProvider);

  Future<Notification> create(Notification notification) async {
    return dataProvider.create(notification);
  }

  Future<List<Notification>> fetchAll() async {
    return dataProvider.fetchAll();
  }
}
