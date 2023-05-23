import 'package:flutter/material.dart';
import 'package:insurance_system/requests.dart';

class UpdateRequestPage extends StatefulWidget {
  final String Description;
  final String location;
  final int numberOfRooms;
  final String status;
  final String CoverageLevel;

  const UpdateRequestPage({
    required this.Description,
    required this.location,
    required this.numberOfRooms,
    required this.status,
    required this.CoverageLevel,
  });

  @override
  _UpdateRequestPageState createState() => _UpdateRequestPageState();
}

class _UpdateRequestPageState extends State<UpdateRequestPage> {
  TextEditingController DescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    DescriptionController.text = widget.Description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Request'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Insurance Detail",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: DescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Perform the update operation here
                final updatedDescription = DescriptionController.text;

                // Navigate back to the detail page with the updated values
                Navigator.pop(
                  context,
                  DetailPage(
                    Description: updatedDescription,
                    CoverageLevel: widget.CoverageLevel, // Keep CoverageLevel constant
                    location: widget.location, // Keep location constant
                    numberOfRooms: widget.numberOfRooms, // Keep numberOfRooms constant
                    status: widget.status, // Keep status constant
                  ),
                );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
