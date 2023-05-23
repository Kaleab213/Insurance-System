import 'package:flutter/material.dart';
import 'package:insurance_system/Add_request.dart';
import 'package:insurance_system/Update_Request.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coverage Requests'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          int level = (index % 3) + 1;
          String status = "pending";
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Insurance Details'),
                    content: DetailPage(
                      Description: ' would greatly appreciate it if you could guide me through the process and provide any necessary forms or documents required. Additionally, it would be incredibly helpful if you could review my policy coverage and clarify any uncertainties I may have. Furthermore, if possible, could you please provide me with an update on the status of my claim? If there is any flexibility, I would like to request an extension for submitting the required documents, as I am experiencing unforeseen circumstances. Lastly, I would be grateful if you could take the time to explain the terms and conditions of my policy in detail. Your support and prompt response to these requests would be immensely appreciated',
                      location: 'Gonder, Ethiopia',
                      numberOfRooms: 4,
                      status: 'pending',
                       CoverageLevel: 'level 1',
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateRequestPage(CoverageLevel: 'Level 1',
                               Description: ' would greatly appreciate it if you could guide me through the process and provide any necessary forms or documents required. Additionally, it would be incredibly helpful if you could review my policy coverage and clarify any uncertainties I may have. Furthermore, if possible, could you please provide me with an update on the status of my claim? If there is any flexibility, I would like to request an extension for submitting the required documents, as I am experiencing unforeseen circumstances. Lastly, I would be grateful if you could take the time to explain the terms and conditions of my policy in detail. Your support and prompt response to these requests would be immensely appreciated',
                                location: 'Gonder, Ethiopia', 
                                numberOfRooms: 4, 
                                status: 'pending',
                                
                              ),
                              // builder: (context) => AdminPage()
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddRequestPage(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddRequestPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(
                        0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Coverage Request',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Home Insurance',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Level $level',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Status $status',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueAccent),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blueAccent),
            label: 'Buy Insurance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.blueAccent),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.blueAccent),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String Description;
  final String location;
  final int numberOfRooms;
  final String status;
  final String CoverageLevel;

  const DetailPage({
    required this.Description,
    required this.location,
    required this.numberOfRooms,
    required this.status,
    required this.CoverageLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Request Detail",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Description: $Description'),
            Text('Location: $location'),
            Text('Number of Rooms: $numberOfRooms'),
            Text('Status: $status'),
            Text('CoverageLevel: $CoverageLevel'),
          ],
        ),
      ),
    );
  }
}
