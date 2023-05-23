import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UpdateInsurancePage extends StatefulWidget {
  final String houseLocation;
  final String houseSize;
  final int numberOfRooms;
  final String propertyType;
  final String coverageLevel;
  final String filePath;

  UpdateInsurancePage({
    required this.houseLocation,
    required this.houseSize,
    required this.numberOfRooms,
    required this.propertyType,
    required this.coverageLevel,
    required this.filePath,
  });

  @override
  _UpdateInsurancePageState createState() => _UpdateInsurancePageState();
}

class _UpdateInsurancePageState extends State<UpdateInsurancePage> {
  String? houseLocation;
  String? houseSize;
  int? numberOfRooms;
  String? propertyType;
  String? coverageLevel;
  String? filePath;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    houseLocation = widget.houseLocation;
    houseSize = widget.houseSize;
    numberOfRooms = widget.numberOfRooms;
    propertyType = widget.propertyType;
    coverageLevel = widget.coverageLevel;
    filePath = widget.filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Insurance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: houseLocation,
                decoration: InputDecoration(labelText: 'House Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the house location';
                  }
                  return null;
                },
                onSaved: (value) {
                  houseLocation = value;
                },
              ),
              TextFormField(
                initialValue: houseSize,
                decoration: InputDecoration(labelText: 'House Size'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the house size';
                  }
                  return null;
                },
                onSaved: (value) {
                  houseSize = value;
                },
              ),
              TextFormField(
                initialValue: numberOfRooms.toString(),
                decoration: InputDecoration(labelText: 'Number of Rooms'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of rooms';
                  }
                  return null;
                },
                onSaved: (value) {
                  numberOfRooms = int.parse(value!);
                },
              ),
              SizedBox(height: 16),
              Text(
                'Type of Property:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: propertyType,
                items: [
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
                    propertyType = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select the type of property';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Levels of Coverage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 1 (100% coverage)',
                    groupValue: coverageLevel,
                    onChanged: (value) {
                      setState(() {
                        coverageLevel = value;
                      });
                    },
                  ),
                  Text('Level 1 (100% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 2 (75% coverage)',
                    groupValue: coverageLevel,
                    onChanged: (value) {
                      setState(() {
                        coverageLevel = value;
                      });
                    },
                  ),
                  Text('Level 2 (75% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 3 (50% coverage)',
                    groupValue: coverageLevel,
                    onChanged: (value) {
                      setState(() {
                        coverageLevel = value;
                      });
                    },
                  ),
                  Text('Level 3 (50% coverage)'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 4 (25% coverage)',
                    groupValue: coverageLevel,
                    onChanged: (value) {
                      setState(() {
                        coverageLevel = value;
                      });
                    },
                  ),
                  Text('Level 4 (25% coverage)'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Legal Ownership Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                child: Text('Pick Document'),
                onPressed: _openFilePicker,
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



