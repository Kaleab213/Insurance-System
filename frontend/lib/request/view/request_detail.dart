import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/request/model/request_model.dart';

import '../bloc/request_bloc.dart';
import '../bloc/request_event.dart';
import 'edit_item.dart';

class RequestDetailScreen extends StatelessWidget {
  late final Request item;

  RequestDetailScreen(this.item);

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
              'Description for Your Request: ${item.description}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text( 
              'The time you ask request: ${item.updatedAt}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            Text(
              'Your Expected loss: ${item.loss}',
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              
                try {
                    final RequestEvent event =
                        RequestApprove(status: true, id: item.id!);
                    BlocProvider.of<RequestBloc>(context).add(event);
                    context.go("/requestList");
                  } catch (error) {
                    context.go("/error");
                  }

            },
            child: const Text('Approve'),
          ),
          ElevatedButton(
            onPressed: () {
               try {
                    final RequestEvent event =
                        RequestApprove(status: false, id: item.id!);
                    BlocProvider.of<RequestBloc>(context).add(event);
                    context.go("/requestList");
                  } catch (error) {
                    context.go("/error");
                  }
            },
            child: const Text('Disapprove'),
          ),
        ],
      ),
    );
  }
}