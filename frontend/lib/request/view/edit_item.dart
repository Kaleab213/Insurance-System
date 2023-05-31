import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_event.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';
import 'package:file_picker/file_picker.dart';

class RequestEditScreen extends StatefulWidget {
  final Request item;

  const RequestEditScreen({super.key, required this.item});

  @override
  _RequestEditScreenState createState() => _RequestEditScreenState();
}

class _RequestEditScreenState extends State<RequestEditScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _policeController = TextEditingController();
  final TextEditingController _supportedController =
      TextEditingController();
  final TextEditingController _lossController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.item);
    print("item");

    _descriptionController.text = widget.item.description.toString();
    _lossController.text = widget.item.loss.toString();
  
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _policeController.dispose();
    _supportedController.dispose();
    _lossController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Request Item'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Request Description',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _lossController,
                  decoration: const InputDecoration(
                    labelText: 'Amount of loss expected',
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Request editedItem;
                    editedItem = Request(
                      loss: double.parse(_lossController.text),
                      description: _descriptionController.text, 
                      police_report: widget.item.police_report,
                      supported_document: widget.item.supported_document,
                     
                    
                    );
                    final RequestEvent event = RequestUpdate(
                        id: widget.item.id!, request: editedItem);
                    BlocProvider.of<RequestBloc>(context).add(event);

                    if (state is RequestDataLoaded) {
                      context.go("/requestList");
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
