import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_state.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

// import '../bloc/farm_bloc.dart';
// import '../../screen/bloc/insurance_state.dart';
// import '../../screen/Admin/add_item.dart';
// import '../../screen/Admin/item_detail.dart';

class AdminInsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminInsuranceBloc, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoadingforAdmin) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InsuranceDataLoadedforAdmin && state.userRole == "ADMIN") {
          final List<Insurance> item = state.myinsurance;
          print("this is my items");
          print(item);
          return Scaffold(
            appBar: AppBar(
              title: Text('Admin Insurance List for Approval'),
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
                          context.push("/admininsurancedetail", extra: item[index]);
                        },
                      );
                    },
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.request_page_outlined),
                  label: 'Insurance Request',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.request_page),
                  label: 'Coverage Request',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Payment',
                ),
              ],
              currentIndex: 0,
              onTap: (int index) {
                if (index == 0) {
                  context.go("/admininsuranceList");
                } else if (index == 1) {
                  context.go('/requestList');
                } else if (index == 2) {
                  context.go('/paymentList');
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
