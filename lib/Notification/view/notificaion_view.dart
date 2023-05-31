import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Notification/bloc/notification_bloc.dart';
import 'package:pro/Notification/bloc/notification_state.dart';
import 'package:pro/Notification/model/notification_model.dart';

class NotificationListScreen extends StatelessWidget {
  final int userID; // Add userID variable to store the logged-in user ID

  NotificationListScreen({required this.userID});

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

          // Filter notifications based on the userID
          final userNotifications = notifications
              .where((notification) => notification.userID == userID)
              .toList();

          if (userNotifications.isEmpty) {
            return const Center(
              child: Text("You have no notifications"),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Notification List'),
            ),
            body: ListView.builder(
              itemCount: userNotifications.length,
              itemBuilder: (context, index) {
                final notification = userNotifications[index];

                return ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                  leading: const Icon(Icons.local_grocery_store),
                  title: Text(notification.userID.toString()),
                  subtitle: Text(notification.note),
                  onTap: () {
                    // Handle notification tap action
                  },
                );
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
