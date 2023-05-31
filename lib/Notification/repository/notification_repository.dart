
// import 'package:pro/herd/data_providers/notification_data_provider.dart'
import 'package:pro/Notification/model/notification_model.dart';import '../data_providers/notification_data_provider.dart';
import '../model/notification_model.dart';


class NotificationRepository {
  final NotificationDataProvider dataProvider;
  NotificationRepository(this.dataProvider);

  Future<Future<Notifications>> fetchOne(String id) async {
    return dataProvider.fetchOne(id);
  }

  Future<Notifications> create(Notifications notification) async {
    return dataProvider.create(notification);
  }

  Future<Notifications> update(String id, Notifications notification) async {
    return dataProvider.update(id, notification);
  }

  Future<List<Notifications>> fetchAll() async {
    return dataProvider.fetchAll();
  }

  Future<void> delete(String id) async {
    dataProvider.delete(id);
  }
}
