import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/request/bloc/request_bloc.dart';
import 'package:pro/request/bloc/request_event.dart';
import 'package:pro/request/bloc/request_state.dart';
import 'package:pro/request/model/request_model.dart';
import 'package:file_picker/file_picker.dart';

class EditItemScreen extends StatefulWidget {
  final Request item;

  const EditItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late File _policeReport;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.item.description;
    _dateController.text = widget.item.date;
    _policeReport = widget.item.policeReport;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Item'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      _policeReport = File(result.files.single.path!);
                    }
                  },
                  child: const Text('Pick Police Report'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Request editedItem = Request(
                      description: _descriptionController.text,
                      date: _dateController.text,
                      policeReport: _policeReport,
                      status: "false",
                      id: widget.item.id,
                    );
                    final RequestEvent event =
                        RequestUpdate(id: widget.item.id, request: editedItem);
                    BlocProvider.of<RequestBloc>(context).add(event);

                    if (state is RequestDataLoaded) {
                      context.go("/RequestList");
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
