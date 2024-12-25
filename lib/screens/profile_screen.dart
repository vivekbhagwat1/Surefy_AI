import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String number;
  final List<Map<String, String>> callHistory;

  ProfileScreen({
    required this.name,
    required this.number,
    required this.callHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add more options here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Contact Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Info',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildContactRow(number, 'Mobile'),
                ],
              ),
            ),
            Divider(height: 40),

            // Call History
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Call History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...callHistory.map((history) {
                    return ListTile(
                      leading: Icon(
                        history["type"]!.contains("CallType.incoming")
                            ? Icons.call_received
                            : history["type"]!.contains("CallType.outgoing")
                                ? Icons.call_made
                                : Icons.call_missed,
                        color: Colors.green,
                      ),
                      title: Text(history["type"]!.split('.').last),
                      subtitle: Text(history["time"] ?? ""),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(String number, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(number, style: TextStyle(fontSize: 16)),
              Text(label, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // Call action
                },
              ),
              IconButton(
                icon: Icon(Icons.message, color: Colors.blue),
                onPressed: () {
                  // Message action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
