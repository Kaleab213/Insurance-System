import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/Insurance/model/insurance_model.dart';

void main() {
  late Insurance item;

  setUp(() {
    item = Insurance(
      id: '1',
      size: 100,
      location: 'Sample Location',
      room: 3,
      type: 'Sample Type',
      level: 'Sample Level',
      status: 'Sample Status',
      Document: InsuranceDocument(path: 'https://example.com/image.png'),
    );
  });

  testWidgets('AdminItemDetailScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AdminItemDetailScreen(item),
      ),
    );

    // Verify the rendered text widgets
    expect(find.text('Insurance Id: ${item.id}'), findsOneWidget);
    expect(find.text('Size: ${item.size}'), findsOneWidget);
    expect(find.text('Location: ${item.location}'), findsOneWidget);
    expect(find.text('Number of rooms: ${item.room}'), findsOneWidget);
    expect(find.text('Property Type: ${item.type}'), findsOneWidget);
    expect(find.text('Coverage level: ${item.level}'), findsOneWidget);
    expect(find.text('Status: ${item.status}'), findsOneWidget);

    // Verify the rendered image widget
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is NetworkImage), findsOneWidget);

    // Simulate tapping the approve button
    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();

    // Verify that the navigation occurs
    expect(find.text('/approval'), findsOneWidget);

    // Simulate tapping the disapprove button
    await tester.tap(find.text('Disapprove'));
    await tester.pumpAndSettle();

    // Add your own assertions for the disapprove functionality if needed
  });
}
