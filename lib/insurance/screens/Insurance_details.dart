import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurancesystem/insurance/insurance.dart';
import 'package:insurancesystem/insurance/screens/Insurance_add.dart';
import 'package:insurancesystem/insurance/screens/Insurance_list.dart';
import 'package:insurancesystem/insurance/screens/Insurance_route.dart';

class InsuranceDetail extends StatelessWidget {
  static const routeName = 'insuranceDetail';
  final Insurance insurance;

  InsuranceDetail({required this.insurance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateInsurance.routeName,
              arguments: InsuranceArgument(insurance: this.insurance, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<InsuranceBloc>().add(InsuranceDelete(this.insurance));
              Navigator.of(context).pushNamedAndRemoveUntil(
                  InsuranceList.routeName, (route) => false);
            },
          ),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('House Size: ${this.insurance.size}'),
              subtitle: Text('Location: ${this.insurance.location}'),
            ),
            ListTile(
              title: Text('Number of Rooms: ${this.insurance.numberOfRooms}'),
              subtitle: Text('Property Type: ${this.insurance.propertyType}'),
            ),
            ListTile(
              title: Text('Coverage Level: ${this.insurance.coverageLevel}'),
            ),
          ],
        ),
      ),
    );
  }
}
