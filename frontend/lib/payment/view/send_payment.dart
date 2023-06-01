// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import 'package:image_picker/image_picker.dart';
// import '../../Insurance/bloc/insurance_event.dart';
// import '../../Insurance/model/insurance_model.dart';
// import '../../user/model/User_model.dart';
// import '../bloc/payment_bloc.dart';
// import '../bloc/payment_event.dart';
// import '../bloc/payment_state.dart';
// import '../model/payment_model.dart';

// class CreatePayment extends StatefulWidget {
//   const CreatePayment({super.key});

//   @override
//   _CreatePaymentState createState() => _CreatePaymentState();
// }

// class _CreatePaymentState extends State<CreatePayment> {
//   // List<int>? _selectedFile;
//   String? _selectedFile;
//   late final User user;
//   late final Insurance insurances;
//   late final Payment pay;
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _billController = TextEditingController();

//   final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
//   // File? _selectedFile;
//   // late final User myUser;

//   @override
//   void dispose() {
//     _amountController.dispose();
//     _billController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PaymentBloc, PaymentState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Create Payment'),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       controller: _amountController,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter the monthly Amount';
//                         }
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         labelText: 'Monthly Amount',
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),

// // on flutter mobile app
//                     ElevatedButton(
//                       onPressed: () async {
//                         final ImagePicker _picker = ImagePicker();
//                         XFile? image = await _picker.pickImage(
//                             source: ImageSource.gallery);

//                         if (image != null) {
//                           List<int> bytes =
//                               await File(image.path).readAsBytes();
//                           String base64File = base64Encode(bytes);

//                           setState(() {
//                             _selectedFile = base64File;
//                             _billController.text = image
//                                 .name; // Set the file name in the controller
//                           });
//                         }
//                       },
//                       child: const Text('Upload payment bill'),
//                     ),

//                     ElevatedButton(
//                       onPressed: () async {
//                         final PaymentEvent event = PaymentCreate(
//                           Payment(
//                             bill: pay.bill,
//                             ammount: double.parse(_amountController.text),
//                           ),
//                         );
//                         // final InsuranceEvent events = InsuranceCreate(
//                         //   Insurance(
//                         //     telebirr_QR: insurances.telebirr_QR,
                            
//                         //   ),
//                         // );

//                         BlocProvider.of<PaymentBloc>(context).add(event);
//                         if (state is PaymentDataLoadingError) {
//                           context.go("/error");
//                         }
//                         if (state is PaymentDataLoaded) {
//                           context.go("/admininsuranceList");
//                         }
//                       },
//                       child: const Text('Send'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
