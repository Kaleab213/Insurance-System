import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../Insurance/model/insurance_model.dart';
import '../../user/model/User_model.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../model/payment_model.dart';

class AddPayment extends StatefulWidget {
  const AddPayment({Key? key}) : super(key: key);

  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  String? _selectedFile;
  late User user;
  late Insurance insurances;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _billController = TextEditingController();

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Payment'),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                key: _formKey2,
                child: Container(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _amountController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your monthly Amount';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Monthly Amount',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                );

                                if (image != null) {
                                  List<int> bytes = await File(image.path).readAsBytes();
                                  String base64File = base64Encode(bytes);

                                  setState(() {
                                    _selectedFile = base64File;
                                    _billController.text = image.name;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.payment,
                                color: Colors.white,
                                size: 24,
                              ),
                              label: const Text(
                                'Upload your bill',
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
                                  
                                  horizontal: 32.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final PaymentEvent event = PaymentCreate(
                                  Payment(
                                    bill: File(_billController.text),
                                    ammount: double.parse(_amountController.text),
                                  ),
                                );
                                BlocProvider.of<PaymentBloc>(context).add(event);
                                if (state is PaymentDataLoadingError) {
                                  context.go("/error");
                                }
                                if (state is PaymentDataLoaded) {
                                  context.go("/insuranceList");
                                }
                              },
                              child: const Text('Pay'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: const EdgeInsets.symmetric(

                                  horizontal: 32.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
