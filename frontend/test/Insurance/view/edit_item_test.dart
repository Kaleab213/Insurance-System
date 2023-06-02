import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_state.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Insurance/view/edit_item.dart';


void main() {
  late Insurance mockItem;

  setUp(() {
    mockItem = Insurance(
      id: '1',
      size: 100,
      location: 'Location 1',
      room: 3,
      level: 'level1',
      type: 'Type 1',
      Document: null,
    );
  });

  testWidgets('EditItemScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<InsuranceBloc>(
          create: (context) => InsuranceBloc(insuranceRepository: null),
          child: EditItemScreen(item: mockItem),
        ),
      ),
    );

    // Verify the initial state of the text fields
    final sizeTextField = find.widgetWithText(TextField, 'House Size');
    expect(sizeTextField, findsOneWidget);
    expect(tester.widget<TextField>(sizeTextField).controller!.text, '100');

    final locationTextField = find.widgetWithText(TextField, 'Location');
    expect(locationTextField, findsOneWidget);
    expect(tester.widget<TextField>(locationTextField).controller!.text, 'Location 1');

    final roomTextField = find.widgetWithText(TextField, 'Number of rooms');
    expect(roomTextField, findsOneWidget);
    expect(tester.widget<TextField>(roomTextField).controller!.text, '3');

    final levelRadioListTile = find.widgetWithText(RadioListTile, 'Level 1, 100% coverage');
    expect(levelRadioListTile, findsOneWidget);
    expect(tester.widget<RadioListTile<String>>(levelRadioListTile).value, 'level1');

    final typeTextField = find.widgetWithText(TextField, 'House Propertyptype');
    expect(typeTextField, findsOneWidget);
    expect(tester.widget<TextField>(typeTextField).controller!.text, 'Type 1');

    // Enter text in the text fields
    await tester.enterText(sizeTextField, '200');
    expect(tester.widget<TextField>(sizeTextField).controller!.text, '200');

    await tester.enterText(locationTextField, 'Location 2');
    expect(tester.widget<TextField>(locationTextField).controller!.text, 'Location 2');

    await tester.enterText(roomTextField, '4');
    expect(tester.widget<TextField>(roomTextField).controller!.text, '4');

    // Tap on the radio list tile
    await tester.tap(levelRadioListTile);
    await tester.pumpAndSettle();

    // Verify the changed values
    expect(tester.widget<TextField>(sizeTextField).controller!.text, '200');
    expect(tester.widget<TextField>(locationTextField).controller!.text, 'Location 2');
    expect(tester.widget<TextField>(roomTextField).controller!.text, '4');
    expect(tester.widget<RadioListTile<String>>(levelRadioListTile).value, 'level1');

    await tester.enterText(typeTextField, 'Type 2');
    expect(tester.widget<TextField>(typeTextField).controller!.text, 'Type 2');

    // Simulate tapping the Save Changes button
    final saveChangesButton = find.widgetWithText(ElevatedButton, 'Save Changes');
    expect(saveChangesButton, findsOneWidget);

    await tester.tap(saveChangesButton);
    await tester.pumpAndSettle();

    // Verify the bloc event and navigation
    final bloc = BlocProvider.of<InsuranceBloc>(tester.element(find.byType(EditItemScreen)));
    expect(bloc.state, isA<InsuranceDataLoaded>());
    expect(bloc.state.items.length, 1);

    final event = bloc.state.items[0];
    expect(event.id, '1');
    expect(event.insurance.size, 200);
    expect(event.insurance.location, 'Location 2');
    expect(event.insurance.room, 4);
    expect(event.insurance.level, 'level1');
    expect(event.insurance.type, 'Type 2');

    final goRouter = GoRouter.of(tester.element(find.byType(EditItemScreen)));
    expect(goRouter.location, '/insuranceList');
  });
}
