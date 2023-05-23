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
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueAccent),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blueAccent),
            label: 'Buy Insurance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.blueAccent),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.blueAccent),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationPage(),
  ));
}
