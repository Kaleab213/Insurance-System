import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Insurance/view/edit_item.dart';

// import '../bloc/farm_bloc.dart';
import '../../Insurance/bloc/insurance_state.dart';
import '../../Insurance/view/add_item.dart';
import '../../Insurance/view/item_detail.dart';

class AdminInsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsuranceBloc, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InsuranceDataLoaded) {
          final List<Insurance> items = state.insurances;
          final List<Insurance> filteredItems =
              items.where((item) => item.status == 'false').toList();
          if (filteredItems.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Insurance List'),
                // actions: [
                //   IconButton(
                //     icon: Icon(Icons.add),
                //     onPressed: () {
                //       if (state is InsuranceDataLoaded) {
                //         context.go("/addinsurance", extra: state.insurances);
                //       }
                //     },
                //   ),
                // ],
              ),
              body: const Center(
                child: Text("No item"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Insurance List'),
                // actions: [
                //   IconButton(
                //     icon: Icon(Icons.add),
                //     onPressed: () {
                //       if (state is InsuranceDataLoaded) {
                //         context.go("/addinsurance", extra: state.insurances);
                //       }
                //     },
                //   ),
                // ],
              ),
              body: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  Insurance item = filteredItems[index];

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                    leading: const Icon(Icons.local_grocery_store),
                    title: Text((item.id).toString()),
                    subtitle: Text(
                      'Location: ${item.location}, size: ${item.size}',
                    ),
                    // trailing: Text('Status: ${item.status}'),
                    onTap: () {
                      context.push('/admininsurancedetail', extra: item);
                    },
                    // Add a button to approve the insurance and update the status
                    trailing: ElevatedButton(
                      onPressed: () {
                        item = Insurance(
                          location: item.location,
                          size: item.size,
                           level: item.level, 
                           room: item.room, 
                           Document: item.Document,
                          type: item.type,
                          

                        );
                        BlocProvider.of<InsuranceBloc>(context).add(
                          EditItemScreen(item: item,) as InsuranceEvent,
                        );
                      },
                      child: Text('Approve'),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          if (state is InsuranceDataLoadingError) {
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
