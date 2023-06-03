import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_event.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';
import 'package:pro/user/model/user_model.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  // List<int>? _selectedFile;
  String? _selectedFile;
  late final User user;
  late final Request requests;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lossController = TextEditingController();
  final TextEditingController _policeController = TextEditingController();

  final TextEditingController _supportedController = TextEditingController();

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  // File? _selectedFile;
  // late final User myUser;

  @override
  void dispose() {
    _descriptionController.dispose();
    _lossController.dispose();
    _policeController.dispose();
    _supportedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Add Request'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your request description';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Request Description',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _lossController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter expected amount of loss';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Expected Loss',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),


// on flutter mobile app
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(allowMultiple: false);

                          if (result != null && result.files.isNotEmpty) {
                            PlatformFile file = result.files.first;
                            List<int> bytes = file.bytes!;
                            String base64File = base64Encode(bytes);

                            setState(() {
                              _selectedFile = base64File;
                              _policeController.text = file
                                  .name; // Set the file name in the controller
                            });
                          }
                        },
                        child: const Text('Upload Police_report Document'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(allowMultiple: false);

                          if (result != null && result.files.isNotEmpty) {
                            PlatformFile file = result.files.first;
                            List<int> bytes = file.bytes!;
                            String base64File = base64Encode(bytes);

                            setState(() {
                              _selectedFile = base64File;
                              _supportedController.text = file
                                  .name; // Set the file name in the controller
                            });
                          }
                        },
                        child: const Text('Upload Supported Document'),
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          String? base64File = _selectedFile;

                          if (base64File != null) {
                            List<int> bytes = base64Decode(base64File);

                            Directory tempDir =
                                await Directory.systemTemp.createTemp();
                            File tempFile = File('${tempDir.path}/tempfile');

                            await tempFile.writeAsBytes(bytes);

                            final RequestEvent event = RequestCreate(
                              Request(
                                loss: double.parse(_lossController.text),
                                description: _descriptionController.text,
                                police_report: tempFile,
                                supported_document: tempFile,
                              ),
                            );
                            BlocProvider.of<RequestBloc>(context).add(event);
                            if (state is RequestDataLoadingError) {
                              context.go("/error");
                            }
                            if (state is RequestDataLoaded) {
                              context.go("/requestList");
                            }
                          }
                        },
                        child: const Text('Add Insurance'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
