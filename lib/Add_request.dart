import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddRequestPage extends StatefulWidget {
  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  DateTime? dateOfLoss;
  String descriptionOfLoss = '';
  String policeReportPath = '';
  String supportedDocumentPath = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickFile(String field) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        if (field == 'Police Report') {
          policeReportPath = result.files.single.path!;
        } else if (field == 'Supported Document') {
          supportedDocumentPath = result.files.single.path!;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Date of Loss'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  dateOfLoss = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ))!;
                  setState(() {});
                },
                validator: (value) {
                  if (dateOfLoss == null) {
                    return 'Please select the date of loss';
                  }
                  return null;
                },
                readOnly: true,
                controller: TextEditingController(
                  text: dateOfLoss != null
                      ? '${dateOfLoss!.day}/${dateOfLoss!.month}/${dateOfLoss!.year}'
                      : '',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description of Loss',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description of loss';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    descriptionOfLoss = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Police Report:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: Text('Upload Police Report'),
                onPressed: () => _pickFile('Police Report'),
              ),
              Text(
                policeReportPath.isNotEmpty ? 'Selected file: $policeReportPath' : '',
              ),
              SizedBox(height: 16),
              Text(
                'Supported Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: Text('Upload Supported Document'),
                onPressed: () => _pickFile('Supported Document'),
              ),
              Text(
                supportedDocumentPath.isNotEmpty ? 'Selected file: $supportedDocumentPath' : '',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                  }
                },
              );
  }})]),
          ),
        ),
      );
  }
}

