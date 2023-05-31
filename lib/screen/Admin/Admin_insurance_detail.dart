import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/model/insurance_model.dart';


class AdminItemDetailScreen extends StatelessWidget {
  late final Insurance item;

  AdminItemDetailScreen({required Insurance insurance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mode_edit),
            onPressed: () {
              context.go("/admineditinsurance", extra: item);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Insurance Id: ${item.id}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Size: ${item.size}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Location: ${item.location}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Number of rooms: ${item.room}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Property Type: ${item.type}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Coverage level: ${item.level}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Status: ${item.status}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                context.go("/setpayment");
              },
              child: const Text('Set Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
