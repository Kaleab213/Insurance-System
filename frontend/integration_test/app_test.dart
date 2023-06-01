
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pro/main.dart' as app;





void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end to end test", () {
     testWidgets("verify Login screen with correct email and username", (tester)async{  
      app.main();
      await tester.pumpAndSettle();
      tester.enterText(find.byType(TextFormField).at(0), 'email');
      tester.enterText(find.byType(TextFormField).at(1), 'password');
      tester.tap(find.byType(ElevatedButton));
      tester.pump();

     });



  });
}