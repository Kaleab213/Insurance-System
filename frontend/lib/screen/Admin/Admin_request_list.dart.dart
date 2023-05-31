import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';

import '../../request/bloc/request_event.dart';
import '../../request/view/edit_item.dart';



class InsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RequestDataLoaded) {
  final Iterable<Request> items = state.requests;
  final List<Request> filteredItems =
      items.where((item) => item.status == 'false').toList();
          if (filteredItems.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Insurance List'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (state is RequestDataLoaded) {
                        context.go("/addinsurance", extra: state.requests);
                      }
                    },
                  ),
                ],
              ),
              body: const Center(
                child: Text("No list"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Insurance List'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (state is RequestDataLoaded) {
                        context.go("/addinsurance", extra: state.requests);
                      }
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  Request item = filteredItems[index];

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                    leading: const Icon(Icons.local_grocery_store),
                    title: Text(item.id),
                    subtitle: Text(
                      'Description: ${item.description}, Date: ${item.date}',
                    ),
                    // trailing: Text('Status: ${item.status}'),
                    onTap: () {
                      context.push('/insurancedetail', extra: item);
                    },
                    trailing: ElevatedButton(
                      onPressed: () {
                        item = Request(
                          id: item.id,
                          description: item.description,
                          date: item.date,
                          status: 'true', 
                          policeReport: item.policeReport,


                        );
                        BlocProvider.of<RequestBloc>(context).add(
                          EditItemScreen(item: item,) as RequestEvent,
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
          if (state is RequestDataLoadingError) {
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
