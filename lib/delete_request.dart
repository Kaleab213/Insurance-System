import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final ImagePicker _picker = ImagePicker();
  XFile? _transactionImage;
  final String itemImageUrl =
      'images/qrcode.jpg'; // Replace with actual image path
  final String itemName = 'Item Name';
  final double amount = 100.0;
  final String deadline = 'May 30, 2023';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _transactionImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payments'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Scan This QR Code to Pay:',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Image.network(
                    itemImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.grey[100],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount: ${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      'Deadline: $deadline',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: Text(
                  'Please upload a screenshot of your transaction:',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 135.0,
                      width: 135.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: _transactionImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.file(
                                File(_transactionImage!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.photo,
                              color: Colors.grey[300],
                              size: 80.0,
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: FloatingActionButton(
                        onPressed: _pickImage,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Upload',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
