import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UpdateRequestPage extends StatefulWidget {
  final DateTime dateOfLoss;
  final String descriptionOfLoss;
  final String policeReportPath;
  final String supportedDocumentPath;

  UpdateRequestPage({
    required this.dateOfLoss,
    required this.descriptionOfLoss,
    required this.policeReportPath,
    required this.supportedDocumentPath,
  });

  @override
  _UpdateRequestPageState createState() => _UpdateRequestPageState();
}

class _UpdateRequestPageState extends State<UpdateRequestPage> {
  DateTime? dateOfLoss;
  String? descriptionOfLoss;
  String? policeReportPath;
  String? supportedDocumentPath;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _pickFile(String field) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        if (field == 'Police Report') {
          policeReportPath = result.files.single.path;
        } else if (field == 'Supported Document') {
          supportedDocumentPath = result.files.single.path;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateOfLoss = widget.dateOfLoss;
    descriptionOfLoss = widget.descriptionOfLoss;
    policeReportPath = widget.policeReportPath;
    supportedDocumentPath = widget.supportedDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Request'),
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
                  dateOfLoss = await showDatePicker(
                    context: context,
                    initialDate: dateOfLoss ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
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
                initialValue: descriptionOfLoss,
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
                supportedDocumentPath != null ? 'Selected file: $supportedDocumentPath' : '',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


