import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/request/model/request_model.dart';

import 'edit_item.dart';

class ItemDetailScreen extends StatelessWidget {
  late final Request item;

  ItemDetailScreen({required Insurance insurance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mode_edit),
            onPressed: () {
              context.go("/editrequest", extra: item);
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
              'Request Id: ${item.id}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${item.description}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${item.date}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'police report: ${item.policeReport}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Status: ${item.status}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
