import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

import '../bloc/insurance_state.dart';
import 'add_item.dart';
import 'item_detail.dart';

class InsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsuranceBloc, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InsuranceDataLoaded && state.userRole == "COSTUMER") {
          final List<Insurance> item = state.insurances;
          print(item);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Insurance List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (state is InsuranceDataLoaded) {
                      context.go("/addinsurance", extra: state.insurances);
                    }
                  },
                ),
              ],
            ),
            body: item.isEmpty
                ? Center(
                    child: Text(
                      "No item",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 0.0),
                            leading: Icon(
                              Icons.local_grocery_store,
                              color: Colors.blue,
                            ),
                            title: Text(
                              (item[index].id!).toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Location: ${item[index].location}, size: ${item[index].size} square meter',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    context.go("/editinsurance", extra: item[index]);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Handle deleting item
                                    // You can show a confirmation dialog and delete the item upon confirmation

                                    final InsuranceEvent event = InsuranceDelete(item[index].id!);
                                              BlocProvider.of<InsuranceBloc>(context).add(event);
                                    BlocProvider.of<InsuranceBloc>(context).add(event);
                                      
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              context.push('/insurancedetail',
                                  extra: item[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  label: 'Profile',
                ),
                
              ],
              currentIndex: 0,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              onTap: (int index) {
                if (index == 0) {
                  context.go('/insuranceList');
                } else if (index == 1) {
                  context.go('/notification');
                } else if (index == 2) {
                  context.go('/profile');
                } else if (index == 3) {
                  context.go('/requestList');
                }
              },
            ),
          );
        } else {
          if (state is InsuranceDataLoadingError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text(
                "Error",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
