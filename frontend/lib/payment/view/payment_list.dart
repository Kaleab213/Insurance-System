import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/payment/model/payment_model.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';

import '../bloc/payment_bloc.dart';
import '../bloc/payment_state.dart';

// import 'add_item.dart';tetete
// import 'request_detail.dart';

class PaymenttListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PaymentDataLoaded) {
          final List<Payment> item = state.payments;

          print("this is the items");
          print(item);
          return Scaffold(
            appBar: AppBar(
              title: Text('Admin payment List For Approval'),
              
            ),
            body: item.isEmpty
                ? const Center(
                    child: Text("No payment list"),
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
                            'date: ${item[index].updatedAt}, loss : ${item[index].ammount}'),
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
                  icon: Icon(Icons.request_page),
                  label: 'Insurance Request',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.request_page_outlined),
                  label: 'Coverage Request',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payments),
                  label: 'Payment',
                ),
              ],
              currentIndex: 2,
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
          if (state is PaymentDataLoadingError) {
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
