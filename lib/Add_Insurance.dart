import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:insurance_system/Add_request.dart';
import 'package:insurance_system/Notification.dart';

class AddInsurancePage extends StatefulWidget {
  @override
  _AddInsurancePageState createState() => _AddInsurancePageState();
}

class _AddInsurancePageState extends State<AddInsurancePage> {
  String houseLocation = '';
  String houseSize = '';
  int numberOfRooms = 0;
  String propertyType = '';
  String coverageLevel = '';
  String filePath = '';
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AddRequestPage(),
    NotificationPage(),

  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Insurance'),
      ),
      body:
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'House Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the house location';
                  }
                  return null;
                },
                onSaved: (value) {
                  houseLocation = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'House Size'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the house size';
                  }
                  return null;
                },
                onSaved: (value) {
                  houseSize = value!;
                },
              ),
              TextFormField(
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
                    propertyType = value!;
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
                'Levels of Coverage:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Level 1 (100% coverage)',
                    groupValue: coverageLevel,
                    onChanged: (value) {
                      setState(() {
                        coverageLevel = value!;
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
                        coverageLevel = value!;
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
                        coverageLevel = value!;
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
                        coverageLevel = value!;
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
                child: Text('Submit'),
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
      
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
        ],
        
      ),
      
    );
  }
  }

    
