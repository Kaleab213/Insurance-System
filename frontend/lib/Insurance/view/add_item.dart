import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker_web/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:pro/Insurance/bloc/farm_bloc.dart';
import 'package:pro/Insurance/bloc/insurance_event.dart';
import 'package:pro/Insurance/bloc/insurance_bloc.dart';
import 'package:pro/Insurance/model/insurance_model.dart';
import 'package:pro/user/model/user_model.dart';
import '../bloc/insurance_state.dart';
import 'package:file_picker/file_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  // List<int>? _selectedFile;
  String? _selectedFile;
  late final User user;
  late final Insurance insurances;
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _DocumentController = TextEditingController();

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  // File? _selectedFile;
  // late final User myUser;

  @override
  void dispose() {
    _typeController.dispose();
    _sizeController.dispose();
    _locationController.dispose();
    _roomController.dispose();
    _levelController.dispose();
    _DocumentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsuranceBloc, InsuranceState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Add Insurance'),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _sizeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your House Size';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'House Size',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _locationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter location';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Location',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _roomController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter number of rooms in your house';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Number of Rooms',
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FormField(
                        builder: (FormFieldState<String> state) {
                          return Column(
                            children: <Widget>[
                              RadioListTile<String>(
                                title: const Text('Level 1, 100% coverage'),
                                value: '1',
                                groupValue: _levelController.text,
                                onChanged: (value) {
                                  setState(() {
                                    _levelController.text = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Level 2, 75% coverage'),
                                value: '2',
                                groupValue: _levelController.text,
                                onChanged: (value) {
                                  setState(() {
                                    _levelController.text = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Level 3, 50% coverage'),
                                value: '3',
                                groupValue: _levelController.text,
                                onChanged: (value) {
                                  setState(() {
                                    _levelController.text = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Level 4, 25% coverage'),
                                value: '4',
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
                        validator: (value) {
                          if (_levelController.text.isEmpty) {
                            return 'Please select a coverage level';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _typeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your house property type';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'House Property Type',
                        ),
                      ),
                      const SizedBox(height: 16.0),

// on flutter mobile app
                      ElevatedButton(
  onPressed: () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      String filePath = file.path!;
      String fileName = path.basename(filePath);

      final bytes = await File(filePath).readAsBytes();
      String base64File = base64Encode(bytes);

      setState(() {
        _selectedFile = base64File;
        _DocumentController.text = fileName;
      });
    }
  },
  child: const Text('Upload Ownership Document'),
),
Text(_DocumentController.text),

ElevatedButton(
  onPressed: () async {
    String? base64File = _selectedFile;

    if (base64File != null) {
      List<int> bytes = base64Decode(base64File);

      Directory tempDir = await Directory.systemTemp.createTemp();
      File tempFile = File('${tempDir.path}/tempfile');

      await tempFile.writeAsBytes(bytes);

      final InsuranceEvent event = InsuranceCreate(
        Insurance(
          size: int.parse(_sizeController.text),
          location: _locationController.text,
          room: int.parse(_roomController.text),
          level: _levelController.text,
          Document: tempFile,
          type: _typeController.text,
        ),
      );
      BlocProvider.of<InsuranceBloc>(context).add(event);

      context.go('/insuranceList');
    }
  },
  child: const Text('Add Insurance'),
),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

// Was this response better or worse?
// Better
// Worse
// Same

//                   ElevatedButton(
//                         onPressed: () async {
//                           FilePicker.platform.pickFiles().then((result) {
//                             if (result != null) {
//                               PlatformFile file = result.files.single;
//                               String filePath = file.path!;
//                               String fileName = file.name;
//                           // FilePickerResult? result = await FilePicker.platform.pickFiles();

//                           // if (result != null) {
//                           //   PlatformFile file = result.files.single;
//                           //   String filePath = file.path!;
//                           //   String fileName = file.name;

//                             setState(() {
//                               _DocumentController.text = fileName;
//                             });
//                           }

//                         child: const Text('Upload Ownership Document'),
//                          }
//                          );})

//                       ElevatedButton(
//                         onPressed: () {

//                               final InsuranceEvent event = InsuranceCreate(
//                                 Insurance(
//                                   size: int.parse(_sizeController.text),
//                                   location: _locationController.text,
//                                   room: int.parse(_roomController.text),
//                                   level: _levelController.text,
//                                   Document: File(filePath),
//                                   type: _typeController.text,
//                                 ),
//                               );
//                               BlocProvider.of<InsuranceBloc>(context).add(event);
//                               if (state is InsuranceDataLoadingError) {
//                                 context.go("/error");
//                               }
//                               if (state is InsuranceDataLoaded) {
//                                 context.go("/insuranceList");
//                               }
//                             }
//                           );
//                         },
//                         child: const Text('Add Insurance'),
//                       ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//       },
//     );
//   }
}
