import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_route.dart';
import '../../models/request.dart';
import 'Update_Request.dart';
import 'delete_request.dart';

class RequestDetail extends StatelessWidget {
  static const routeName = 'requestDetail';
  final Request request;

  RequestDetail({required this.request});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              UpdateRequest.routeName,
              arguments: RequestArgument(request: request, edit: true),
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Navigator.of(context).pushNamed(
              DeleteRequest.routeName,
              arguments: RequestArgument(request: request, edit: false),
            ),
          ),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            Text('Request-ID: ${this.request.coverage_id}'),
            // subtitle: Text('location: ${this.request.location}')
            const SizedBox(
              height: 10,
            ),
            Text('Insurancelevel: ${this.request.level}'),
            // subtitle: Text('location: ${this.request.location}')
            const SizedBox(
              height: 10,
            ),
            Text('Witness Phone Number 1: ${this.request.witness1Number}'),
            // subtitle: Text('location: ${this.request.location}')
            const SizedBox(
              height: 10,
            ),
            Text('Witness Phone Number 2: ${this.request.witness2Number}'),
            // subtitle: Text('location: ${this.request.location}')
            const SizedBox(
              height: 10,
            ),
            Text('Witness Phone Number 3: ${this.request.witness3Number}'),
            // subtitle: Text('location: ${this.request.location}')
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
