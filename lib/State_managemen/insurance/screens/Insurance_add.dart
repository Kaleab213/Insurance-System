import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurancesystem/insurance/models/insurance.dart';
import 'package:insurancesystem/insurance/screens/Insurance_list.dart';
import 'package:insurancesystem/insurance/screens/Insurance_route.dart';

class AddUpdateInsurance extends StatefulWidget {
  static const routeName = 'insuranceAddUpdate';
  final InsuranceArgument? args;

  AddUpdateInsurance({required this.args});

  @override
  _AddUpdateInsuranceState createState() => _AddUpdateInsuranceState();
}

class _AddUpdateInsuranceState extends State<AddUpdateInsurance> {
  final _formKey = GlobalKey<FormState>();
  final _propertyTypeList = ['Single-Family House', 'Condominium'];
  String? _selectedPropertyType;
  String? _selectedCoverageLevel;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _numberOfRoomsController = TextEditingController();

  // bool _isLegalOwnershipDocumentUploaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.args!.edit) {
      _locationController.text = widget.args!.insurance.location;
      _sizeController.text = widget.args!.insurance.size;
      _numberOfRoomsController.text = widget.args!.insurance.numberOfRooms.toString();
      _selectedPropertyType = widget.args!.insurance.propertyType;
      _selectedCoverageLevel = widget.args!.insurance.coverageLevel;
      // _isLegalOwnershipDocumentUploaded = widget.args!.insurance.isLegalOwnershipDocumentUploaded;
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _sizeController.dispose();
    _numberOfRoomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args!.edit ? "Update Insurance" : "Add Insurance"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _locationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter house location';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'House Location'),
              ),
              TextFormField(
                controller: _sizeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter house size';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'House Size'),
              ),
              TextFormField(
                controller: _numberOfRoomsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter number of rooms';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Number of Rooms'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedPropertyType,
                onChanged: (value) {
                  setState(() {
                    _selectedPropertyType = value;
                  });
                },
                items: _propertyTypeList.map((propertyType) {
                  return DropdownMenuItem<String>(
                    value: propertyType,
                    child: Text(propertyType),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Type of Property'),
              ),
              SizedBox(height: 16),
              Text(
                'Levels of Coverage:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                title: Text('Level 1 (100% coverage)'),
                value: 'Level 1',
                groupValue: _selectedCoverageLevel,
                onChanged: (value) {
                  setState(() {
                    _selectedCoverageLevel = value;
                  });
                },
              ),
             
                RadioListTile(
                title: Text('Level 2 (75% coverage)'),
                value: 'Level 2',
                groupValue: _selectedCoverageLevel,
                onChanged: (value) {
                  setState(() {
                    _selectedCoverageLevel = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Level 3 (50% coverage)'),
                value: 'Level 3',
                groupValue: _selectedCoverageLevel,
                onChanged: (value) {
                  setState(() {
                    _selectedCoverageLevel = value;
                  });
                },
              ),
              RadioListTile(
                title: Text('Level 4 (25% coverage)'),
                value: 'Level 4',
                groupValue: _selectedCoverageLevel,
                onChanged: (value) {
                  setState(() {
                    _selectedCoverageLevel = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                'Legal Ownership Document:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement the upload functionality here
                  setState(() {
                    // _isLegalOwnershipDocumentUploaded = true;
                  });
                },
                child: Text('Upload Document'),
              ),
              SizedBox(height: 16),
              Padding(
  padding: const EdgeInsets.symmetric(vertical: 16.0),
  child: ElevatedButton.icon(
    onPressed: () {
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();
        final Insurance insurance = Insurance(
          // id: int.parse(Insurance.fromJson("id" as Map<String, dynamic>) as String),
          size: _sizeController.text,
          location: _locationController.text,
          numberOfRooms: int.parse(_numberOfRoomsController.text),
          propertyType: _selectedPropertyType!,
          coverageLevel: _selectedCoverageLevel!,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          InsuranceList.routeName,
          (route) => false,
          arguments: insurance,
        );
      }
    },
    label: Text('SAVE'),
    icon: Icon(Icons.save),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
