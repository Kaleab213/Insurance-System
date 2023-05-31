import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';

import 'add_item.dart';
import 'request_detail.dart';

class InsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RequestDataLoaded) {
          final Iterable<Request> requests = state.requests; // Change variable type to Iterable<Request>
          final List<Request> item = requests.toList();
          print(item);
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
            body: item.isEmpty
                ? const Center(
                    child: Text("No item"),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                        leading: const Icon(Icons.local_grocery_store),
                        title: Text(item[index].id),
                        subtitle: Text(
                            'Description: ${item[index].description}, Date : ${item[index].date}'),
                        trailing: Text('Status: ${item[index].status}'),
                        onTap: () {
                          context.push('/insurancedetail', extra: item[index]);
                        },
                      );
                    },
                  ),
          );
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
