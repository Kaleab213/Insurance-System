import 'package:flutter/material.dart';

class PremiumRequest {
  final String name;
  final int level;
  final int amount;
  final String status;

  PremiumRequest({
    required this.name,
    required this.level,
    required this.amount,
    required this.status,
  });
}

class PaymentRequest extends StatefulWidget {
  @override
  _PaymentRequestState createState() => _PaymentRequestState();
}

class _PaymentRequestState extends State<PaymentRequest> {
  List<PremiumRequest> _requests = [];

  @override
  void initState() {
    super.initState();
    _requests = [
      PremiumRequest(
        name: 'John Doe',
        level: 2,
        amount: 3000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      PremiumRequest(
        name: 'Jane Smith',
        level: 1,
        amount: 5000,
        status: 'pending',
      ),
      // Add more sample data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Approval'),
      ),
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Do something when the tile is tapped
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.assignment, size: 40.0),
                    title: Text(
                        '${_requests[index].name} - level: ${_requests[index].level}'),
                    subtitle: Text(
                        'Amount: ${_requests[index].amount}\nStatus: ${_requests[index].status}'),
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
