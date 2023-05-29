import 'package:flutter/material.dart';

class InsuranceRequest {
  final String name;
  final int level;
  final String status;

  InsuranceRequest({
    required this.name,
    required this.level,
    required this.status,
  });
}

class InsuranceList extends StatefulWidget {
  @override
  _InsuranceListState createState() => _InsuranceListState();
}

class _InsuranceListState extends State<InsuranceList> {
  List<InsuranceRequest> _requests = [];

  @override
  void initState() {
    super.initState();
    _requests = [
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'Jane Smith', level: 3, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      InsuranceRequest(name: 'John Doe', level: 2, status: 'pending'),
      // Add more sample data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Request List'),
      ),
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("yessss");
              // Do something when the tile is tapped
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.assignment, size: 40.0),
                    title: Text(
                        '${_requests[index].name}  \nlevel: ${_requests[index].level}'),
                    subtitle: Text('\nStatus: ${_requests[index].status}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
