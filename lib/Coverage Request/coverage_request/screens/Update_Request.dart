import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_route.dart';
import '../blocs/blocs.dart';
import 'requests.dart';
import '../models/models.dart';

class UpdateRequest extends StatefulWidget {
  static const routeName = 'RequestUpdate';
  final RequestArgument args;

  UpdateRequest({required this.args});
  @override
  _UpdateRequestState createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  final _formKey = GlobalKey<FormState>();
  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _request["ownershipdocument"] = result.files.single.path!;
      });
    }
  }

  final Map<String, dynamic> _request = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update_Request"}'),
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
                      return 'Please enter House Size';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'House size'),
                  onSaved: (value) {
                    setState(() {
                      this._request["size"] = value;
                    });
                  }),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter House Location';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'House Location'),
                  onSaved: (value) {
                    this._request["location"] = value;
                  }),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter numberofrooms';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Number of Rooms'),
                  onSaved: (value) {
                    setState(() {
                      this._request["numberofrooms"] = int.parse(value!);
                    });
                  }),
              const SizedBox(height: 16),
              const Text(
                'Type of Property:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Single-Family House',
                    child: Text('Single-Family House'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Condominium',
                    child: Text('Condominium'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    this._request["propertytype"] = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select the type of property';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Levels of Coverage:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 1 (100% coverage)',
                    groupValue: _request["coveragelevel"],
                    onChanged: (value) {
                      setState(() {
                        this._request["coveragelevel"] = value;
                      });
                    },
                  ),
                  const Text('Level 1 (100% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 2 (75% coverage)',
                    groupValue: _request["coveragelevel"],
                    onChanged: (value) {
                      setState(() {
                        _request["coveragelevel"] = value!;
                      });
                    },
                  ),
                  const Text('Level 2 (75% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 3 (50% coverage)',
                    groupValue: _request["coveragelevel"],
                    onChanged: (value) {
                      setState(() {
                        _request["coveragelevel"] = value;
                      });
                    },
                  ),
                  const Text('Level 3 (50% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 4 (25% coverage)',
                    groupValue: _request["coveragelevel"],
                    onChanged: (value) {
                      setState(() {
                        _request["coveragelevel"] = value!;
                      });
                    },
                  ),
                  const Text('Level 4 (25% coverage)'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Legal Ownership Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: const Text('Pick Document'),
                onPressed: _openFilePicker,
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

                      RequestUpdate(
                        widget.args.request?.coverage_id ?? 0,
                        Request(
                          coverage_id: this._request["coverage_id"],
                          date: this._request["date"],
                          description: this._request["description"],
                          insurance_id: this._request["insurance_id"],
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
