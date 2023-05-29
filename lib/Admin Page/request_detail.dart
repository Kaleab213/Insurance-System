import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CoverageDetail extends StatefulWidget {
  final String username;
  final String houseSize;
  final double houseAge;
  final String houseLocation;
  final int insurance_id;
  final int insuranceLevel;
  final int houseNumber;
  final String date_of_loss;
  final String description_of_loss;
  final String phone_number1;
  final String phone_number2;
  final String phone_number3;
  // final File policeReport;

  const CoverageDetail({
    required this.username,
    required this.houseSize,
    required this.houseAge,
    required this.houseLocation,
    required this.houseNumber,
    required this.insuranceLevel,
    required this.date_of_loss,
    required this.description_of_loss,
    required this.insurance_id,
    required this.phone_number1,
    required this.phone_number2,
    required this.phone_number3,
    // required this.policeReport,
  });

  @override
  _CoverageDetailState createState() => _CoverageDetailState();
}

class _CoverageDetailState extends State<CoverageDetail> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coverage Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name:      ${widget.username}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Age:      ${widget.houseAge}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Location:  ${widget.houseLocation}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Number:    ${widget.houseNumber}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'House Size:      ${widget.houseSize}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Coverage Level:   ${widget.insuranceLevel}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Date Of Loss:     ${widget.date_of_loss}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Insurance Id:     ${widget.insurance_id}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Phone Number of Witness1: ${widget.phone_number1}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Phone Number of Witness2: ${widget.phone_number2}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Phone Number of Witness3: ${widget.phone_number3}',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Description Of Loss: \n${widget.description_of_loss}',
                style: const TextStyle(fontSize: 18),
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
