import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurancesystem/insurance/bloc/insurance_bloc.dart';
import 'package:insurancesystem/insurance/insurance.dart';
import 'package:insurancesystem/insurance/screens/Insurance_add.dart';
import 'package:insurancesystem/insurance/screens/Insurance_details.dart';
import 'package:insurancesystem/insurance/screens/Insurance_route.dart';

class InsuranceList extends StatelessWidget {
  static const routeName = '/';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Insurances'),
      ),
      body: BlocBuilder<InsuranceBloc, InsuranceState>(
        builder: (_, state) {
          if (state is InsuranceOperationFailure) {
            return Text('Could not perform insurance operation');
          }

          if (state is InsurancesLoadSuccess) {
            final insurances = state.insurances;

            return ListView.builder(
              itemCount: insurances.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('House Size: ${insurances[idx].size}'),
                subtitle: Text('Location: ${insurances[idx].location}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(InsuranceDetail.routeName, arguments: insurances[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateInsurance.routeName,
          arguments: InsuranceArgument(edit: false, insurance: null!),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
