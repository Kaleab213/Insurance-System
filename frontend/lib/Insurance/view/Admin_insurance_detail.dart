import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

import '../bloc/insurance_state.dart';

class AdminItemDetailScreen extends StatelessWidget {
  late final Insurance item;

  AdminItemDetailScreen(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              Image.network(
                item.Document!.path,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  try {
                    final InsuranceEvent event =
                        InsuranceApprove(status: true, id: item.id!);
                    BlocProvider.of<AdminInsuranceBloc>(context).add(event);
                    context.go("/admininsuranceList");
                  } catch (error) {
                    context.go("/error");
                  }
                },
                child: const Text('Approve'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  try {
                    final InsuranceEvent event =
                        InsuranceApprove(status: false, id: item.id!);
                    BlocProvider.of<AdminInsuranceBloc>(context).add(event);
                    context.go("/admininsuranceList");
                  } catch (error) {
                    context.go("/error");
                  }
                },
                child: const Text('Disapprove'),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
