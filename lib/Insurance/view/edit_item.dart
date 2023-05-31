import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:pro/Insurance/bloc/farm_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';

import '../bloc/insurance_state.dart';
import '../model/insurance_model.dart';

class EditItemScreen extends StatefulWidget {
  final Insurance item;

  const EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _roomController =
      TextEditingController();
  final TextEditingController _levelController =
      TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _DocumentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.item);
    print("item");

    _sizeController.text = widget.item.size.toString();
    _locationController.text = widget.item.location;
    _roomController.text = widget.item.room.toString();
    _levelController.text = widget.item.level.toString();
    _typeController.text = widget.item.type.toString();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _locationController.dispose();
    _roomController.dispose();
    _levelController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsuranceBloc, InsuranceState>(
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
                TextField(
                  controller: _sizeController,
                  decoration: const InputDecoration(
                    labelText: 'House Size',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _roomController,
                  decoration: const InputDecoration(
                    labelText: 'Number of rooms',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                FormField(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      children: <Widget>[
                        RadioListTile<String>(
                          title: const Text('Level 1, 100% coverage'),
                          value: 'level1',
                          groupValue: _levelController.text,
                          onChanged: (value) {
                            setState(() {
                              _levelController.text = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Level 2, 75% coverage'),
                          value: 'level2',
                          groupValue: _levelController.text,
                          onChanged: (value) {
                            setState(() {
                              _levelController.text = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Level 3, 50% coverage'),
                          value: 'level3',
                          groupValue: _levelController.text,
                          onChanged: (value) {
                            setState(() {
                              _levelController.text = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Level 4, 25% coverage'),
                          value: 'level4',
                          groupValue: _levelController.text,
                          onChanged: (value) {
                            setState(() {
                              _levelController.text = value!;
                            });
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: 'House Propertyptype',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Insurance editedItem;
                    editedItem = Insurance(
                      size: int.parse(_sizeController.text),
                      location: _locationController.text,
                      room: int.parse(_roomController.text),
                      level: _levelController.text,
                      type: _typeController.text,
                      Document: widget.item.Document
                     
                    
                    );
                    final InsuranceEvent event = InsuranceUpdate(
                        id: widget.item.id!, insurance: editedItem);
                    BlocProvider.of<InsuranceBloc>(context).add(event);

                    if (state is InsuranceDataLoaded) {
                      context.go("/insuranceList");
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
