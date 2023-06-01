import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';

import 'add_item.dart';
import 'request_detail.dart';

class RequestListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RequestDataLoaded) {
          final List<Request> item = state.requests;

          print("this is the items");
          print(item);
          return Scaffold(
            appBar: AppBar(
              title: Text('Request List'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (state is RequestDataLoaded) {
                      context.go("/addrequest", extra: state.requests);
                    }
                  },
                ),
              ],
            ),
            body: item.isEmpty
                ? const Center(
                    child: Text("No request list"),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                        leading: const Icon(Icons.local_grocery_store),
                        title: Text((item[index].id!).toString()),
                        subtitle: Text(
                            'date: ${item[index].updatedAt}, loss : ${item[index].loss}'),
                        trailing: Text('Status: ${item[index].status}'),
                        onTap: () {
                          context.push('/requestdetail', extra: item[index]);
                        },
                      );
                    },
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: Colors.blueAccent,
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  backgroundColor: Colors.blueAccent,
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Insurance',
                  backgroundColor: Colors.blueAccent,
                ),
              ],
              currentIndex: 0,
              onTap: (int index) {
                if (index == 0) {
                  context.go('/insuranceList');
                } else if (index == 1) {
                  context.go('/mynotification');
                } else if (index == 2) {
                  context.go('/profile');
                } else if (index == 3) {
                  context.go('/insuranceList');
                }
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
