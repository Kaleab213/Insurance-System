import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro/Insurance/view/insurance_list.dart';
import 'package:pro/Insurance/view/item_detail.dart';
import 'package:pro/auth/view/auth/login_page.dart';
import 'package:pro/main.dart' as app;
import 'package:pro/user/view/auth/sign_up.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end to end test", () {
    IntegrationTestWidgetsFlutterBinding binding =
        IntegrationTestWidgetsFlutterBinding.ensureInitialized() as IntegrationTestWidgetsFlutterBinding;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // Initialize the database factory
      databaseFactory = databaseFactoryFfi;

      // Open the database
      final database = await databaseFactory.openDatabase('path/to/insurance.db');

      // Run the app
      app.main();
    });

    testWidgets("Login screen verify with correct email and password",
        (tester) async {
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).first, 'lemma@gmail.com');
      await Future.delayed(const Duration(seconds: 4));

      await tester.enterText(find.byType(TextFormField).last, 'lemma');
      await Future.delayed(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextButton));

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 4));

      expect(find.byType(ListView), findsNWidgets(1));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 4));
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(ItemDetailScreen), findsOneWidget);
    });

    testWidgets("Signup screen user verify", (tester) async {
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 4));
      await tester.tap(find.byType(CreateAccount as Type));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 4));
      expect(find.byType(SignUpPages), findsOneWidget);
    });
  });
}
