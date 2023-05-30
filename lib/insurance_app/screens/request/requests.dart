import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_detail.dart';
import '../../models/request.dart';

class Requests extends StatefulWidget {
  static const routeName = '/';
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Requests> {
  int _selectedIndex = 1;
  late final Request request;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coverage Requests'),
        centerTitle: true,
      ),
      body: BlocBuilder<RequestBloc, RequestState>(
        builder: (_, state) {
          if (state is RequestOperationFailure) {
            return const Text('Could not do request operation');
          }

          if (state is RequestOperationSuccess) {
            final requests = state.requests;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: requests.length,
              itemBuilder: (context, idx) {
                int? level = this.request.level;
                String? status = this.request.status;
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      RequestDetail.routeName,
                      arguments: requests.elementAt(idx)),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: const CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.question_mark_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  requests
                                      .elementAt(idx)
                                      .coverage_id
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  requests
                                      .elementAt(idx)
                                      .coverage_id
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  requests
                                      .elementAt(idx)
                                      .coverage_id
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Status $status',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueAccent),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blueAccent),
            label: 'Buy Insurance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.blueAccent),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.blueAccent),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
