import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:pro/Insurance/bloc/farm_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/Notification/model/notification_model.dart';
// import 'package:pro/Payment/bloc/payment_bloc.dart';
// import 'package:pro/Payment/model/payment_model.dart';
import 'package:pro/payment/bloc/payment_event.dart';
import 'package:pro/payment/bloc/payment_state.dart';
import 'package:pro/payment/model/payment_model.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:file_picker/file_picker.dart';

import '../../payment/bloc/payment_bloc.dart';

class setPayment extends StatefulWidget {
  const setPayment({Key? key}) : super(key: key);

  @override
  _setPaymentState createState() => _setPaymentState();
}

class _setPaymentState extends State<setPayment> {
  late final User user;
  late final Payment pay;
  late final Insurance insurances;
  final TextEditingController _monthlyAmountController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _qrcode;
  
  late Notifications not;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _monthlyAmountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Set Payment'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _monthlyAmountController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Monthly Amount';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Monthly Amount',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _dateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Date';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (result != null) {
                        setState(() {
                          _qrcode = File(result.files.single.path!);
                        });
                      }
                    },
                    child: const Text('Pick QR Code Image'),
                  ),
                  if (_qrcode != null) ...[
                    const SizedBox(height: 16.0),
                    Image.file(_qrcode!),
                  ],
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        final PaymentEvent event = PaymentCreate(
                          Payment(
                            amount: int.parse(_monthlyAmountController.text),
                             date: _dateController.text,
                              id: pay.id,
                               image: pay.image,
                                qrcode: pay.qrcode
                            
                          ));
                        BlocProvider.of<PaymentBloc>(context).add(event);
                        final String monthlyAmount =
                            _monthlyAmountController.text;
                        final String date = _dateController.text;
                        final String qrcodePath = _qrcode!.path;
                        final String approvedMessage = "Approved Message";
                        final String userId = user.id;

                        final String note =
                            "Monthly Amount :${monthlyAmount}+Date of Paymnet$date+ Qrcode +$qrcodePath+ approvedMessage + $approvedMessage+  userId + $userId";
                         not.note = note;

                        // Navigate to the desired screen
                        if (state is PaymentDataLoadingError) {
                        context.go("/error");
                      }
                      if (state is PaymentDataLoaded) {
                        context.go("/admininsuranceList");
                      }
                      }
                    },
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
