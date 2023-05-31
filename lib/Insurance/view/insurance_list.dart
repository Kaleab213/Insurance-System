import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

// import '../bloc/farm_bloc.dart';
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
        if (state is InsuranceDataLoaded) {
          final List<Insurance> item = state.insurances;
          print(item);
          return Scaffold(
            appBar: AppBar(
              title: Text('Insurance List'),
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
                        title: Text((item[index].id!).toString()),
                        subtitle: Text(
                            'Location: ${item[index].location}, size : ${item[index].size}'),
                        trailing: Text('Status: ${item[index].status}'),
                        onTap: () {
                          context.push('/insurancedetail', extra: item[index]);
                        },
                      );
                    },
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
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
