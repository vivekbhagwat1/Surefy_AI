import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  // Mock data for messages
  final List<Map<String, dynamic>> messages = [
    {
      "name": "+91 9685485260",
      "message": "Hi, Can you tell me your name?",
      "type": "Personal",
      "time": "12:00 pm",
      "status": "unread",
    },
    {
      "name": "Tejal",
      "message": "Hi, How are you!",
      "type": "Personal",
      "time": "Yesterday",
      "status": "read",
    },
    {
      "name": "Akshada",
      "message": "Typing...",
      "type": "Business",
      "time": "",
      "status": "typing",
    },
    {
      "name": "+91 9685485260",
      "message": "Hi, Can you tell me your name?",
      "type": "Business",
      "time": "24/7/2024",
      "status": "read",
    },
    {
      "name": "+91 9685...",
      "message": "Hi, Can you tell me your name?",
      "type": "Business",
      "time": "24/7/2024",
      "status": "read",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SUREFY.AI"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterButton("Contacts"),
                _buildFilterButton("Messages", isSelected: true),
                _buildFilterButton("Favorites"),
              ],
            ),
          ),
          // Messages List
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
  leading: CircleAvatar(
    backgroundColor: Colors.blueAccent,
    child: Text(
      message['name'][0],
      style: const TextStyle(color: Colors.white),
    ),
  ),
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(  // Wrap the name text with Expanded
        child: Text(
          message['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      Text(
        message['time'],
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    ],
  ),
  subtitle: Row(
    children: [
      Expanded(  // Wrap the message text with Expanded
        child: Text(
          message['message'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      const SizedBox(width: 8),
      if (message['type'] != null)
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: message['type'] == "Personal"
                ? Colors.green.shade100
                : Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message['type'],
            style: TextStyle(
              color: message['type'] == "Personal"
                  ? Colors.green
                  : Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    ],
  ),
  trailing: message['status'] == "unread"
      ? const Icon(
          Icons.markunread,
          color: Colors.red,
        )
      : message['status'] == "typing"
          ? const Text(
              "Typing...",
              style: TextStyle(color: Colors.blue),
            )
          : null,
  onTap: () {
 
                  },
              );

              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new message action
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // Navigate between tabs
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.connect_without_contact), label: 'Connects'),
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: 'Dialpad'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Reachouts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, {bool isSelected = false}) {
    return TextButton(
      onPressed: () {
        // Handle filter button press
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
