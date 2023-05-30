import 'package:flutter/material.dart';

class UpdateInsurancePage extends StatefulWidget {
  final String size;
  final String location;
  final int numberOfRooms;
  final String propertyType;
  final String coverageLevel;

  const UpdateInsurancePage({
    required this.size,
    required this.location,
    required this.numberOfRooms,
    required this.propertyType,
    required this.coverageLevel,
    required String filePath,
  });

  @override
  _UpdateInsurancePageState createState() => _UpdateInsurancePageState();
}

class _UpdateInsurancePageState extends State<UpdateInsurancePage> {
  TextEditingController sizeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController numberOfRoomsController = TextEditingController();
  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController coverageLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sizeController.text = widget.size;
    locationController.text = widget.location;
    numberOfRoomsController.text = widget.numberOfRooms.toString();
    propertyTypeController.text = widget.propertyType;
    coverageLevelController.text = widget.coverageLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Insurance'),
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
              controller: sizeController,
              decoration: InputDecoration(
                labelText: 'Size',
              ),
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
              ),
            ),
            TextFormField(
              controller: numberOfRoomsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Rooms',
              ),
            ),
            TextFormField(
              controller: propertyTypeController,
              decoration: InputDecoration(
                labelText: 'Property Type',
              ),
            ),
            TextFormField(
              controller: coverageLevelController,
              decoration: InputDecoration(
                labelText: 'Coverage Level',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Perform the update operation here
                final updatedSize = sizeController.text;
                final updatedLocation = locationController.text;
                final updatedNumberOfRooms =
                    int.parse(numberOfRoomsController.text);
                final updatedPropertyType = propertyTypeController.text;
                final updatedCoverageLevel = coverageLevelController.text;

                // Navigate back to the detail page with the updated values
                Navigator.pop(
                  context,
                  // DetailPage(
                  //   size: updatedSize,
                  //   location: updatedLocation,
                  //   numberOfRooms: updatedNumberOfRooms,
                  //   propertyType: updatedPropertyType,
                  //   coverageLevel: updatedCoverageLevel,
                  // ),
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
