import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';
import '../child/child_login_screen.dart';

class NgoHomeScreen extends StatefulWidget {
  const NgoHomeScreen({Key? key}) : super(key: key);

  @override
  _NgoHomeScreenState createState() => _NgoHomeScreenState();
}

class _NgoHomeScreenState extends State<NgoHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [CreateEventScreen(), ViewEventsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Events',
          ),
        ],
      ),
    );
  }
}

class CreateEventScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController timingController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  String titleError = '';
  String descriptionError = '';
  String contactError = '';
  String locationError = '';
  String timingError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(),
            ),
            ListTile(
              title: TextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    goTo(context, LoginScreen());
                  } on FirebaseAuthException catch (e) {
                    dialogueBox(context, e.toString());
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.pink, // Set the text color to pink
                ),
                child: Text(
                  "SIGN OUT",
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 43, 98),
        title: Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Event Description'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact details'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: timingController,
                decoration: InputDecoration(labelText: 'Timing'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Reset previous error messages
                  titleError = '';
                  descriptionError = '';
                  timingError = '';
                  contactError = '';
                  locationError = '';

                  // Check for errors and show messages
                  if (titleController.text.isEmpty) {
                    titleError = 'Title cannot be empty';
                  }

                  if (locationController.text.isEmpty) {
                    locationError = 'Enter the Event location';
                  }
                  if (timingController.text.isEmpty) {
                    timingError = 'Timing is required';
                  }
                  if (contactController.text.isEmpty) {
                    contactError = 'Enter contact details';
                  }
                  if (descriptionController.text.isEmpty) {
                    descriptionError = 'Description cannot be empty';
                  }

                  if (titleError.isEmpty &&
                      descriptionError.isEmpty &&
                      contactError.isEmpty &&
                      locationError.isEmpty &&
                      timingError.isEmpty) {
                    // Both fields are not empty, proceed with event creation
                    saveEventToDatabase(
                        titleController.text,
                        descriptionController.text,
                        contactController.text,
                        timingController.text,
                        locationController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Event Created'),
                      ),
                    );

                    // Clear the text fields after creating the event
                    titleController.clear();
                    descriptionController.clear();
                    contactController.clear();
                    locationController.clear();
                    timingController.clear();

                    // Navigator.pop(context);
                  } else {
                    // Show an error message or handle the case where fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          titleError.isNotEmpty
                              ? titleError
                              : descriptionError.isNotEmpty
                                  ? descriptionError
                                  : timingError.isNotEmpty
                                      ? timingError
                                      : contactError.isNotEmpty
                                          ? contactError
                                          : locationError.isNotEmpty
                                              ? locationError
                                              : 'Please fill all the fields.',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 234, 43, 107)),
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveEventToDatabase(String title, String description, String contact,
      String timing, String location) {
    FirebaseFirestore.instance.collection('events').add({
      'title': title,
      'description': description,
      'contact': contact,
      'timing': timing,
      'location': location
    });
  }
}

class ViewEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 208, 43, 98),
        title: Text('View Events'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var events = snapshot.data?.docs;
          return ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              var event = events![index].data() as Map<String, dynamic>;
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(event['title']),
                  subtitle: Text(event['description']),
                  onTap: () {
                    // Handle tapping the card to view more details
                    _viewEventDetails(context, event);
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement logic to delete the event
                      deleteEvent(events[index].id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Event Deleted'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void deleteEvent(String eventId) {
    FirebaseFirestore.instance.collection('events').doc(eventId).delete();
  }

  void _viewEventDetails(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            event['title'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 29, 111, 149),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Description', event['description']),
              _buildDetailRow('Location', event['location']),
              _buildDetailRow('Contact', event['contact']),
              _buildDetailRow('Timing', event['timing']),
              // Add more fields as needed
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 29, 111, 149),
              ),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 29, 111, 149),
            ),
          ),
          SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
