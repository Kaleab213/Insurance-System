import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:mockito/mockito.dart';

class MockInsuranceBloc extends Mock implements InsuranceBloc {}

void main() {
  late InsuranceBloc insuranceBloc;
  late User user;
  late Insurance insurance;

  setUp(() {
    insuranceBloc = MockInsuranceBloc();
    user = User(); // Create a sample user object if needed
    insurance = Insurance(level: ''); // Create a sample insurance object if needed
  });

  tearDown(() {
    insuranceBloc.close();
  });

  testWidgets('AddItemScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<InsuranceBloc>.value(
            value: insuranceBloc,
            child: AddItemScreen(),
          ),
        ),
      ),
    );

    // Enter values into the form fields
    await tester.enterText(find.byKey(const Key('sizeField')), '100');
    await tester.enterText(find.byKey(const Key('locationField')), 'Sample Location');
    await tester.enterText(find.byKey(const Key('roomField')), '3');
    await tester.enterText(find.byKey(const Key('typeField')), 'Sample Type');

    // Simulate tapping the upload button
    await tester.tap(find.byKey(const Key('uploadButton')));
    await tester.pumpAndSettle();

    // Verify that the upload process is triggered
    verify(insuranceBloc.add(InsuranceCreate(
      Insurance(
        size: 100,
        location: 'Sample Location',
        room: 3,
        level: null,
        Document: anyNamed('Document'),
        type: 'Sample Type',
      ),
    ))).called(1);

    // Simulate tapping the add insurance button
    await tester.tap(find.byKey(const Key('addInsuranceButton')));
    await tester.pumpAndSettle();

    // Verify that the add insurance process is triggered
    verify(insuranceBloc.add(any)).called(1);

    // Verify that the navigation occurs
    expect(find.text('/insuranceList'), findsOneWidget);
  });
}
