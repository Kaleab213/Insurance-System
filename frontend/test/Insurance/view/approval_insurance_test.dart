import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Insurance/view/approval_insurance.dart';


void main() {
  late Insurance mockItem;

  setUp(() {
    mockItem = Insurance(
      id: '1',
      size: 100,
      location: 'Location 1',
      status: 'Status 1', level: '',
    );
  });

  testWidgets('ApprovalPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ApprovalPage(mockItem),
      ),
    );

    // Verify the initial state of the text field
    final textField = find.byType(TextFormField);
    expect(textField, findsOneWidget);
    expect(tester.widget<TextFormField>(textField).controller!.text, '');

    // Enter text in the text field
    await tester.enterText(textField, '500');
    expect(tester.widget<TextFormField>(textField).controller!.text, '500');

    // Verify the initial state of the QR Code file
    final pickQRCodeFileButton = find.byType(ElevatedButton).first;
    expect(pickQRCodeFileButton, findsOneWidget);
    expect(find.text('Picked File:'), findsNothing);
    expect(find.text('No file picked'), findsNothing);

    // Simulate picking a QR Code file
    await tester.tap(pickQRCodeFileButton);
    await tester.pumpAndSettle();

    final filePickerResult = FilePickerResult(
      [FilePickerResultItem(filePath: '/path/to/qr_code.png')],
    );

    await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
      'flutter.io/filePicker', // The channel name
      FilePicker.platform.codec.encodeSuccessEnvelope(filePickerResult.toJson()),
      (ByteData? data) {},
    );

    await tester.pumpAndSettle();

    // Verify the picked file is displayed
    expect(find.text('Picked File:'), findsOneWidget);
    expect(find.text('/path/to/qr_code.png'), findsOneWidget);

    // Simulate tapping the Finish button
    final finishButton = find.byType(ElevatedButton).last;
    expect(finishButton, findsOneWidget);

    await tester.tap(finishButton);
    await tester.pumpAndSettle();

    // Add your own assertions for the finish button functionality if needed
  });
}
