import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_route.dart';
import '../../blocs/blocs.dart';
import 'requests.dart';
import '../../models/models.dart';

class AddRequest extends StatefulWidget {
  static const routeName = 'RequestAdd';
  final RequestArgument args;

  AddRequest({required this.args});
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
  final _formKey = GlobalKey<FormState>();
  Future<void> _openFilePicker1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _request["ownershipdocument"] = result.files.single.path!;
      });
    }
  }

  Future<void> _openFilePicker2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _request["police_report"] = result.files.single.path!;
      });
    }
  }

  final Map<String, dynamic> _request = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add_Request"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the Loss Description';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Loss Description'),
                  onSaved: (value) {
                    setState(() {
                      this._request["description"] = value;
                      this._request["paymentAmount"] = 0;
                    });
                  }),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the phone number of witness 1';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: '  Phone Number 1'),
                  onSaved: (value) {
                    this._request["witness1Number"] = value;
                  }),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the phone number of witness 2';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Phone Number 2'),
                  onSaved: (value) {
                    setState(() {
                      this._request["witness2Number"] = int.parse(value!);
                    });
                  }),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the phone number of witness 3';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Phone Number 3'),
                  onSaved: (value) {
                    setState(() {
                      this._request["witness3Number"] = int.parse(value!);
                    });
                  }),
              const SizedBox(height: 16),
              const Text(
                'Police Report Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Police Report'),
                onPressed: _openFilePicker1,
              ),
              const SizedBox(height: 16),
              const Text(
                'Police Report Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Police Report'),
                onPressed: _openFilePicker2,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      final RequestEvent event =
                          widget.args.request as RequestEvent;

                      RequestCreate(
                        Request(
                          description: this._request["description"],
                          paymentAmount: this._request["paymentAmount"],
                          witness1Number: this._request["witness1Number"],
                          witness2Number: this._request["witness2Number"],
                          witness3Number: this._request["witness3Number"],
                          police_report: this._request["police_report"],
                          supporting_document:
                              this._request["supporting_document"],
                        ),
                      );
                      BlocProvider.of<RequestBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Requests.routeName, (route) => false);
                    }
                  },
                  label: const Text('SAVE'),
                  icon: const Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
