import 'package:flutter/material.dart';
import 'purchases.dart';
import 'payments.dart';
import 'requests.dart';
import 'delete_insurance.dart';
import 'delete_request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PurchasesPage(),
    );
  }
}
