import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

import 'edit_item.dart';

class ItemDetailScreen extends StatelessWidget {
  late final Insurance item;
  late final Request coverage_request;

  ItemDetailScreen(this.item);

  @override
  Widget build(BuildContext context) {
    List? myrequest = item.coverage_request;
    print(item);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Item Detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.mode_edit,
              color: Colors.white,
            ),
            onPressed: () {
              context.go("/editinsurance", extra: item);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailItem(
                label: 'Insurance Id',
                value: item.id.toString(),
                icon: Icons.person_outline,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'House Size',
                value: item.size.toString(),
                icon: Icons.home,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'Location',
                value: item.location,
                icon: Icons.location_on,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'Number of rooms',
                value: item.room.toString(),
                icon: Icons.meeting_room,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'Property Type',
                value: item.type,
                icon: Icons.home,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'Coverage level',
                value: item.level,
                icon: Icons.shield,
              ),
              SizedBox(height: 16.0),
              DetailItem(
                label: 'Status',
                value: item.status.toString(),
                icon: Icons.check_circle_outline,
              ),
              SizedBox(height: 16.0),
              // DetailItem(
              //   label: 'coverage level',
              //   value: item.coverage_request,
              //   icon: Icons.check_circle_outline,
              // ),
              // SizedBox(height: 16.0),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Center(
                child: Text(
                  'Requests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: item.coverage_request != null
                      ? item.coverage_request!.length
                      : 0,
                  itemBuilder: (context, index) {
                    final coverageRequest = item.coverage_request![index];


                    return ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                      leading: const Icon(Icons.local_grocery_store),
                      title: Text(coverageRequest.id.toString()),
                      subtitle: Text(
                          'date: ${coverageRequest.updatedAt}, loss: ${coverageRequest.loss}'),
                      trailing: Text('Status: ${coverageRequest.status}'),
                      onTap: () {
                        context.push('/requestdetail', extra: coverageRequest);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/addrequest');
            },
            child: Text('Add Request'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/payment');
            },
            child: Text('Payment'),
          ),
          BottomNavigationBar(
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
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
                label: 'Request',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (int index) {
              if (index == 0) {
                context.go('/insuranceList');
              } else if (index == 1) {
                context.go('/mynotification');
              } else if (index == 2) {
                context.go('/profile');
              } else if (index == 3) {
                context.go('/requestList');
              }
            },
          ),
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  DetailItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20.0,
          color: Colors.grey[700],
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
