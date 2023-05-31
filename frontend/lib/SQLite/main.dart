import 'package:flutter/material.dart';
import 'dbhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.testDb();
    return MaterialApp(
        title: 'Shoppping List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container());
  }
}
