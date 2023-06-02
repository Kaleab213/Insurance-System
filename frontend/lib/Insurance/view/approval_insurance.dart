import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../model/insurance_model.dart';

class ApprovalPage extends StatelessWidget {
  late final Insurance item;

  ApprovalPage(this.item);
  final TextEditingController monthlyPaymentController = TextEditingController();
  File? qrCodeFile;

  Future<void> pickQRCodeFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      qrCodeFile = File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            TextFormField(
              controller: monthlyPaymentController,
              decoration: InputDecoration(
                labelText: 'Monthly Payment',
              ),
            ),
            ElevatedButton(
              onPressed: pickQRCodeFile,
              child: Text('Pick QR Code File'),
            ),
            SizedBox(height: 16.0),
            if (qrCodeFile != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Picked File:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(qrCodeFile!.path),
                  SizedBox(height: 16.0),
                ],
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Finish button functionality
              },
              child: Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
