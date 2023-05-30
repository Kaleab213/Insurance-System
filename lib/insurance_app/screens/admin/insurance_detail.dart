import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InsuranceDetail extends StatefulWidget {
  final String username;
  final String houseSize;
  final double houseAge;
  final String houseLocation;
  final int houseNumber;
  final int insuranceLevel;
  // final File ownershipDocument;

  const InsuranceDetail({
    required this.username,
    required this.houseSize,
    required this.houseAge,
    required this.houseLocation,
    required this.houseNumber,
    required this.insuranceLevel,
    // required this.ownershipDocument,
  });

  @override
  _InsuranceDetailState createState() => _InsuranceDetailState();
}

class _InsuranceDetailState extends State<InsuranceDetail> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _paymentAmountController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _paymentAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _paymentAmountController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _storeData() {
    // TODO: Implement your database storage logic here.
  }

  void _deleteData() {
    // TODO: Implement your database storage logic here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name: ${widget.username}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Age: ${widget.houseAge}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Location: ${widget.houseLocation}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Number: ${widget.houseNumber}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Size: ${widget.houseSize}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Insurance Level: ${widget.insuranceLevel}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter the amount of payment',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: _paymentAmountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Payment Amount',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid payment amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Upload an Image of the QR code',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 8),
              if (_image != null) ...[
                SizedBox(
                  height: 200,
                  child: Image.file(_image!),
                ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    // onPressed: _isPremiumApproved ? null : _approvePremium,
                    onPressed: () {},
                    child: const Text('Approve Request'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {},
                    // onPressed: _isPremiumApproved ? _declinePremium : null,
                    child: const Text('Decline Request'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
