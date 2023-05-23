import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class Notification {
  final String title;
  final String description;
  final DateTime date;

  Notification({required this.title, required this.description,required this.date});
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notification> notifications = [
    Notification(
      title: 'Notification 1',
      description: 'This is notification 1',
      date: DateTime(2023, 5, 20),
    ),
    Notification(
      title: 'Notification 2',
      description: 'This is notification 2',
      date: DateTime(2023, 5, 21),
    ),
    Notification(
      title: 'Notification 3',
      description: 'This is notification 3',
      date: DateTime(2023, 5, 19),
    ),
  ];

  @override
  void initState() {
    super.initState();
    sortNotificationsByDate();
  }

  void sortNotificationsByDate() {
    notifications.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.description),
            trailing: Text(
              '${notification.date.day}/${notification.date.month}/${notification.date.year}',
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationPage(),
  ));
}
