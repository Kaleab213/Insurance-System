import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_event.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({Key? key}) : super(key: key);

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _policeReportController = TextEditingController();

  late final  Request requested;

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    _policeReportController.dispose();
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
          body: Padding(
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
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _dateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please choose a date';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Date',
                    ),
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        _dateController.text =
                            selectedDate.toString(); 
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        String filePath = result.files.single.path!;
                        setState(() {
                          _policeReportController.text = filePath;
                        });
                      }
                    },
                    child: const Text('Pick Police Report'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        // Form is valid, proceed with adding the request
                        final RequestEvent event = RequestCreate(
                          Request(
                            description: _descriptionController.text,
                            date: _dateController.text,
                            policeReport: File(_policeReportController.text),
                             id: requested.id,status:"false",
                          ),
                        );
                        BlocProvider.of<RequestBloc>(context).add(event);
                        if (state is RequestDataLoadingError) {
                          context.go("/error");
                        }
                        if (state is RequestDataLoaded) {
                          context.go("/insuranceList");
                        }
                      }
                    },
                    child: const Text('Add Request'),
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
