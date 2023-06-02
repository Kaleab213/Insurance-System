import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:your_app_name/bloc/request_bloc.dart';
import 'package:your_app_name/bloc/request_event.dart';
import 'package:your_app_name/bloc/request_state.dart';
import 'package:your_app_name/model/request_model.dart';
import 'package:your_app_name/model/user_model.dart';
import 'package:your_app_name/screen/add_request_screen.dart';

void main() {
  late RequestBloc requestBloc;

  setUp(() {
    requestBloc = RequestBloc();
  });

  testWidgets('AddRequestScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RequestBloc>.value(
          value: requestBloc,
          child: GoRouter(
            routes: {},
            initialLocation: '/addRequest',
            child: AddRequestScreen(),
          ),
        ),
      ),
    );

    // Verify the presence of form fields and buttons
    expect(find.text('Add Request'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsNWidgets(3));

    // Simulate entering values in the form fields
    await tester.enterText(find.byType(TextFormField).first, 'Test description');
    await tester.enterText(find.byType(TextFormField).at(1), '1000');

    // Simulate tapping the upload buttons
    await tester.tap(find.text('Upload Police_report Document'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Upload Supported Document'));
    await tester.pumpAndSettle();

    // Simulate tapping the Add Insurance button
    await tester.tap(find.text('Add Insurance'));
    await tester.pumpAndSettle();

    // Verify the state and navigation
    expect(requestBloc.state, isA<RequestCreate>());
    expect(find.text('Error'), findsNothing);
    expect(find.text('Request List'), findsOneWidget);
  });
}
