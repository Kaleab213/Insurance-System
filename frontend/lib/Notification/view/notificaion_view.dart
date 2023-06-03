import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Notification/bloc/notification_bloc.dart';
import 'package:pro/Notification/bloc/notification_state.dart';
import 'package:pro/Notification/model/notification_model.dart';

class NotificationListScreen extends StatelessWidget {


  NotificationListScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NotificationDataLoaded) {
          final List<Notifications> notifications =
              List<Notifications>.from(state.notifications);

          if (notifications.isEmpty) {
            return const Center(
              child: Text("You have no notifications"),
            );
          }

          
          

          if (notifications.isEmpty) {
            return const Center(
              child: Text("You have no notifications"),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Notification List'),
            ),
            body: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                  leading: const Icon(Icons.local_grocery_store),
                  title: Text(notification.title.toString()),
                  subtitle: Text(notification.note),
                  onTap: () {
                    
                  },
                );
              },
            ),
             bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  label: 'Profile',
                ),
                
              ],
              currentIndex: 1,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: (int index) {
                if (index == 0) {
                  context.go('/insuranceList');
                } else if (index == 1) {
                  context.go('/notification');
                } else if (index == 2) {
                  context.go('/profile');
                } else if (index == 3) {
                  context.go('/requestList');
                }
              },
            ),
          );
        } else {
          if (state is NotificationDataLoadingError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
      },
    );
  }
}
